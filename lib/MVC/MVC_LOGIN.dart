class MVC_LOGIN {
  String? MVC_Variable_AgentId;
  int? MVC_Variable_IsAdminRights;
  String? MVC_Variable_UserName;
  String? MVC_Variable_Token;

  MVC_LOGIN(
      {this.MVC_Variable_AgentId,
      this.MVC_Variable_IsAdminRights,
      this.MVC_Variable_UserName,
      this.MVC_Variable_Token});

  MVC_LOGIN.fromJson(Map<String, dynamic> json) {
    MVC_Variable_AgentId = json['agentId'];
    MVC_Variable_IsAdminRights = json['isAdminrights'];
    MVC_Variable_UserName = json['userName'];
    MVC_Variable_Token = json['token'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();

    data['agentId'] = this.MVC_Variable_AgentId;
    data['isAdminrights'] = this.MVC_Variable_IsAdminRights;
    data['userName'] = this.MVC_Variable_UserName;
    data['token'] = this.MVC_Variable_Token;
    return data;
  }
}
