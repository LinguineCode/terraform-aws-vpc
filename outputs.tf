output "vpc_id" {
  value = "${aws_vpc.main.id}"
}

output "default_security_group_id" {
  value = "${aws_default_security_group.default.id}"
}

locals {
  empty_list            = ["","","","","","","","","",""]

  private_subnet_padded = "${concat(var.private_subnet_nametags,local.empty_list)}"
  private_subnet_ids_type0 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,0)}")),list(""))}"
  private_subnet_ids_type1 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,1)}")),list(""))}"
  private_subnet_ids_type2 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,2)}")),list(""))}"
  private_subnet_ids_type3 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,3)}")),list(""))}"
  private_subnet_ids_type4 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,4)}")),list(""))}"
  private_subnet_ids_type5 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,5)}")),list(""))}"
  private_subnet_ids_type6 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,6)}")),list(""))}"
  private_subnet_ids_type7 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,7)}")),list(""))}"
  private_subnet_ids_type8 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,8)}")),list(""))}"
  private_subnet_ids_type9 = "${coalescelist(matchkeys(aws_subnet.private.*.id, aws_subnet.private.*.tags.Description,list("${element(local.private_subnet_padded,9)}")),list(""))}"

  public_subnet_padded = "${concat(var.public_subnet_nametags,local.empty_list)}"
  public_subnet_ids_type0 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,0)}")),list(""))}"
  public_subnet_ids_type1 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,1)}")),list(""))}"
  public_subnet_ids_type2 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,2)}")),list(""))}"
  public_subnet_ids_type3 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,3)}")),list(""))}"
  public_subnet_ids_type4 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,4)}")),list(""))}"
  public_subnet_ids_type5 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,5)}")),list(""))}"
  public_subnet_ids_type6 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,6)}")),list(""))}"
  public_subnet_ids_type7 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,7)}")),list(""))}"
  public_subnet_ids_type8 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,8)}")),list(""))}"
  public_subnet_ids_type9 = "${coalescelist(matchkeys(aws_subnet.public.*.id, aws_subnet.public.*.tags.Description,list("${element(local.public_subnet_padded,9)}")),list(""))}"

}

output "private_subnet_ids" {
  value = "${map(coalesce(element(local.private_subnet_padded,0),"unused0"),local.private_subnet_ids_type0,coalesce(element(local.private_subnet_padded,1),"unused1"),local.private_subnet_ids_type1,coalesce(element(local.private_subnet_padded,2),"unused2"),local.private_subnet_ids_type2,coalesce(element(local.private_subnet_padded,3),"unused3"),local.private_subnet_ids_type3,coalesce(element(local.private_subnet_padded,4),"unused4"),local.private_subnet_ids_type4,coalesce(element(local.private_subnet_padded,5),"unused5"),local.private_subnet_ids_type5,coalesce(element(local.private_subnet_padded,6),"unused6"),local.private_subnet_ids_type6,coalesce(element(local.private_subnet_padded,7),"unused7"),local.private_subnet_ids_type7,coalesce(element(local.private_subnet_padded,8),"unused8"),local.private_subnet_ids_type8,coalesce(element(local.private_subnet_padded,9),"unused9"),local.private_subnet_ids_type9)}"
}

output "public_subnet_ids" {
  value = "${map(coalesce(element(local.public_subnet_padded,0),"unused0"),local.public_subnet_ids_type0,coalesce(element(local.public_subnet_padded,1),"unused1"),local.public_subnet_ids_type1,coalesce(element(local.public_subnet_padded,2),"unused2"),local.public_subnet_ids_type2,coalesce(element(local.public_subnet_padded,3),"unused3"),local.public_subnet_ids_type3,coalesce(element(local.public_subnet_padded,4),"unused4"),local.public_subnet_ids_type4,coalesce(element(local.public_subnet_padded,5),"unused5"),local.public_subnet_ids_type5,coalesce(element(local.public_subnet_padded,6),"unused6"),local.public_subnet_ids_type6,coalesce(element(local.public_subnet_padded,7),"unused7"),local.public_subnet_ids_type7,coalesce(element(local.public_subnet_padded,8),"unused8"),local.public_subnet_ids_type8,coalesce(element(local.public_subnet_padded,9),"unused9"),local.public_subnet_ids_type9)}"
}
