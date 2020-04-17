provider "aws" {
  region = "${var.aws_region}"
  access_key = "${var.access_key}"
  secret_key = "${var.secret_key}"
}

module "ubuntu_inst" {
  source = "./ubuntu-instances"
  ami    = "${var.ami}"
  instance_type = "${var.instancetype}"
  instance_count = "${var.instance_cnt}"
  security_groups = var.vpc_security_group_ids_list
  key_pair = "${var.key}"
  
}
module "elb" {
  source = "./loadbalancer"
  lb_name = "${var.lb_name}"
  subnet_ids = var.subnet_ids
  security_groups = var.vpc_security_group_ids_list
  internal = "${var.internal}"
  instance_ids = module.ubuntu_inst.instance_id
  cross_zone_load_balancing = "${var.cross_zone_load_balancing}"
  idle_timeout = "${var.idle_timeout}"
  connection_draining = "${var.connection_draining}"
  connection_draining_timeout = "${var.connection_draining_timeout}"
  instance_port = "${var.instance_port}"
  instance_protocol = "${var.instance_protocol}"
  lb_port = "${var.lb_port}"
  lb_protocol = "${var.lb_protocol}"
  healthy_threshold = "${var.healthy_threshold}"
  unhealthy_threshold = "${var.unhealthy_threshold}"
#  health_check_target = "${var.health_check_target}"
  timeout = "${var.timeout}"
  interval = "${var.intervel}"
}
