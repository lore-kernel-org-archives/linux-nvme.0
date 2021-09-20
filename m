Return-Path: <SRS0=JSVl=OK=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=0.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FORGED_HOTMAIL_RCVD2,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DEECAC433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 17:14:48 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 9BF7163212
	for <linux-nvme@archiver.kernel.org>; Mon, 20 Sep 2021 17:14:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org 9BF7163212
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=hotmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:MIME-Version:In-Reply-To:References:
	Message-ID:Date:Subject:To:From:Reply-To:Cc:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=L5+UQ88VnXaHW+nwz+DZlrZAtWsCTyPzxO7osHRKlsQ=; b=gK615ZR6TDmhpf
	vH8SE+G51KQXow9BjsX/DaV8igz/PKpoM3GUR6sDWd0JkCm540pogf37Mu3C4vQCrpypPlGvAy2/h
	ya+xYBMNXaRKve5ICzjcfOw4m6mR03P1dvdJOrkxwhnbBvt9QikLfdIDbJhASz0+HOffFQU7EbMtb
	OvftvB7m6liWJbJMUCyqjkhuvIPuhFzwM5GiA9x58kwpMZWWStSiTP+3uHSVMhXqRwdbYSycQfUGY
	9KMRqj/vGeF1Ik+cJPxVapIJNX+O75hr/1lSF8RWR91wZys2hMuBI4J7zMVr1w2XcgCKCI2323t7K
	sE8hy+hVMAFqT7hFGX2Q==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mSMsL-002Zbc-BP; Mon, 20 Sep 2021 17:14:41 +0000
Received: from mail-mw2nam10olkn2096.outbound.protection.outlook.com
 ([40.92.42.96] helo=NAM10-MW2-obe.outbound.protection.outlook.com)
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mSMsH-002ZaS-0z
 for linux-nvme@lists.infradead.org; Mon, 20 Sep 2021 17:14:38 +0000
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KzI1hMYZci9xlbYd5bAuBA2ogCWybAzZ0svXAmYP2y6GtQhRvzu33jvetkOhr5V5Xt0oJrCseJ9zIrIvy7U0V4Mdas25HcqXlpTCvSlRMOo4aPMlJ1Zj+wOphqmZl9tz67qrbhNuqnxKy03rXHLnSxi0EjofG+3b3xUqBLMeCeI/JICX/jcsMbM0Ev3x8cuzIXMpzTtEM+owhsTzr2bgW43Vjdw913ts6OFyd2t5X7CninB2ao6q+TR7hQ5fuUBGXFIGjTYhzAcVotu4zkA/S/xnJn3Tsi7Bj6bF9UWJ7wo0IVNTiRuttEDI+1yl5Jrjm3O0zYFbzWN6czZnA0Z6NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com; 
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version; 
 bh=h16YrvhL3cQ/7fMCPEV5nEHAU+prBp5rpAaZh7iMQd4=;
 b=M1UFyNTO5MU5J/EoAIIgE5nWOYaJYyXWlUxw9B+CEeKSX99VMqHwsl++eld1O19rpvBKB1HprlycMku6p6Kbr6J6BOOhUC5wwHpJhFVznRJ/RzOfM6ioW6OehazeIjy8k8w/OjxvHk0kq4+VInuaaVxxAoswzAzovEL2G8jtN1HtX9xON7JJ81BtJnHtv3AR5db+hNekKEEpwjcLEMgj7pewhgtV204EU9io6FR1bM/A3KE/Pun0s1XnFNfxlqscvBmQxDnD4J18YMPC2w2b2BueZnzDEq+5gLSaeO5052Cb2oXLhsNqDjUYtnr2N5E1yt2nbV33TTl1xJrazwu5lQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=hotmail.com;
 s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=h16YrvhL3cQ/7fMCPEV5nEHAU+prBp5rpAaZh7iMQd4=;
 b=cO/yyKVIOXZMyhAU5CIwcb+MAKsr0WUL3luhJbhvMKydXzhYzS7P8R3Sionahc8uunQQFOpfghHl8oIGUybj5YrXbWcC9T8bdl8AXjkmhT7jgSGQIEn7ucijNNEBcl3mDpIr+UEKPD2JbSGg9uEQVy+7W50JVnMA77IuejALZozMtSFcko0c+hT9a+jBQmE08a6viYR8ysWmy9/Kbs1oW5bpCAZl4AALShI4M1dupmrExBsCsIprrjvKJf4QDEJdVVK076ihx5mw/O6oqXOdTlvKN9tTGIgX2PJMuuyW9hfjMZSqExHiwKe4EBAGwUfBQ7cs8Mnr2wQ0ObdmcSF7lg==
Received: from BL0PR13MB4291.namprd13.prod.outlook.com (2603:10b6:208:8e::12)
 by MN2PR13MB3101.namprd13.prod.outlook.com (2603:10b6:208:155::19)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4544.11; Mon, 20 Sep
 2021 17:14:29 +0000
Received: from BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::6426:e628:63a1:3fd1]) by BL0PR13MB4291.namprd13.prod.outlook.com
 ([fe80::6426:e628:63a1:3fd1%7]) with mapi id 15.20.4544.013; Mon, 20 Sep 2021
 17:14:29 +0000
From: Martin Belanger <nitram_67@hotmail.com>
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
Subject: Re: nvme-fabrics: shutdown 1-minute deadlock
Thread-Topic: nvme-fabrics: shutdown 1-minute deadlock
Thread-Index: AQHXriWm12aptTAE/UKf5Uqmtmxxr6utKAQm
Date: Mon, 20 Sep 2021 17:14:29 +0000
Message-ID: <BL0PR13MB4291F9AFF41FE9492FC84B199CA09@BL0PR13MB4291.namprd13.prod.outlook.com>
References: <BL0PR13MB429131886435C5C7092275A39CA09@BL0PR13MB4291.namprd13.prod.outlook.com>
In-Reply-To: <BL0PR13MB429131886435C5C7092275A39CA09@BL0PR13MB4291.namprd13.prod.outlook.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
suggested_attachment_session_id: 3248e631-bf96-1ce9-eedf-e4ef475d8aee
x-ms-exchange-messagesentrepresentingtype: 1
x-tmn: [sMRriuGFpH4RXOvX4FHLuRK+Ip5PO99o]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 073318fa-dc3d-4f04-65bc-08d97c5a1b4f
x-ms-traffictypediagnostic: MN2PR13MB3101:
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: A71MuPp9ZzIZU/hx53C94L5Wuav0JWmQGpiWUtGx3ct7fmX3xJYqea55YKJ/Y5Uq3rVUyQm11aqKJ8aLxX5LvX04mWHM5S3NdQ4FjXAHx6WgvnMLm4IhIdFleDly8lJcEHhOtkXk6c7HBDcQudgb0KQ9050eEYev/Hj5o1dI/SFVEbIyXrQfl024juyHHmx4JtH1y7I9VO6QN4fpb8GIESGRXJ7iDg+xKHoqUtfreqZKUwx+YMod46smRRNzbLaAV7MhD2Vtc3JSfsrycayKRg4kMPZT131Qyq1gsqAEbeMwS81UPeJ5Dl28uWtJre5f7qUShpXLVZcZ8sLyGWvg9uSoSIqPeHZROuO39ijkXDkFHnaWC1Pwn5B7tJohfNZTSYsIavxrOEx/O7Wsh59YAM+QClr0ikI8jsf64sbvdUQlnyCAgS1d+CKOJOAIj/Cs
x-ms-exchange-antispam-messagedata-chunkcount: 1
x-ms-exchange-antispam-messagedata-0: uWSYyfRbY4vdacdMtpdGOzHqvRWeiMWu5Tv/S+XJGs9q9WcYj4tmOcKmcO5ZCnikNrKxJrTom+AmfQDPdkpUNQsU2P+R474Oqxy78B+09iAdmM6r7y/myLrquYL0sUEWhLwR0BQmbNE3ukt98L28Qw==
x-ms-exchange-transport-forked: True
MIME-Version: 1.0
X-OriginatorOrg: sct-15-20-3174-8-msonline-outlook-32ef5.templateTenant
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-AuthSource: BL0PR13MB4291.namprd13.prod.outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: 073318fa-dc3d-4f04-65bc-08d97c5a1b4f
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Sep 2021 17:14:29.5715 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR13MB3101
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210920_101437_287378_4ADC28CD 
X-CRM114-Status: GOOD (  17.65  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.34
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hello NVMe community,

I ran into a 1-minute deadlock trying to disconnect from a remote discovery=
 controller=A0(over tcp) while the controller is unreachable. The remote co=
ntroller could be unreachable because the network is down or the controller=
 simply crashed unexpectedly. The cause is irrelevant. Suffice it to say th=
at the kernel does not yet know that the controller is unreachable and we'r=
e trying to disconnect from the controller. The problem is that during a di=
sconnect we try to write commands to the remote controller and the default =
timeout for a write operation is 1 minute (admin_timeout).=A0

For example, in=A0nvme_shutdown_ctrl() we call reg_write32() (which really =
invokes nvmf_reg_write32) to set the=A0NVME_CC_SHN_NORMAL bit, and this ope=
ration will block waiting for a response that will never come. Interestingl=
y, in the same function we also call=A0reg_read32() to read the CSTS regist=
er, but this time we specify a 5-sec timeout (i.e. ctrl->shutdown_timeout).=
 In other words, there is an inconsistency between the write and the read t=
imeouts in that one function.=A0

Similarly,=A0nvme_disable_ctrl() calls=A0reg_write32() (i.e.=A0nvmf_reg_wri=
te32) to clear=A0NVME_CC_ENABLE and=A0NVME_CC_SHN_MASK, and once again this=
 will block for 1 minute if the controller in unreachable.=A0

I would like to propose that the prototype for=A0reg_write32() be changed t=
o allow for the caller to specify a timeout as follows:

int (*reg_write32)(struct nvme_ctrl *ctrl, u32 off, u32 val, unsigned timeo=
ut);

This timeout will simply be passed to=A0nvmf_reg_write32() and in turn to _=
_nvme_submit_sync_cmd().

When invoking reg_write32(), one would set timeout to 0=A0(zero) to indicat=
e that the default 1-minute timeout shall be used. Otherwise, a non-0 timeo=
ut would overwrite the default. It's only in functions=A0nvme_shutdown_ctrl=
() and=A0nvme_disable_ctrl() that we would specify a timeout shorter than 1=
 minute. For example, we could use=A0ctrl->shutdown_timeout as the value fo=
r timeout.

I would like to hear your thoughts before I submit a patch. Maybe there's a=
 better or easier way to work around this.

Regards,
Martin Belanger
Engineering Technologist, Dell Inc.


Here's another suggestion. Instead of changing the prototype for reg_write3=
2(), in nvmf_reg_write32() we could simply check ctrl->state and if the sta=
te indicates that the ctrl is being deleted, then use ctrl->shutdown_timeou=
t as the timeout. All the changes are limited to this one function as shown=
 below.

int nvmf_reg_write32(struct nvme_ctrl *ctrl, u32 off, u32 val)
{
	struct nvme_command cmd =3D { };
	int ret;
	unsigned timeout =3D 0;

	/* Use shutdown timeout when the controller is being deleted */
	switch (ctrl->state) {
	case NVME_CTRL_DELETING:
	case NVME_CTRL_DELETING_NOIO:
	case NVME_CTRL_DEAD:
		timeout =3D jiffies + (ctrl->shutdown_timeout * HZ);
		break;
	default:
		timeout =3D 0;
		break;
	}

	cmd.prop_set.opcode =3D nvme_fabrics_command;
	cmd.prop_set.fctype =3D nvme_fabrics_type_property_set;
	cmd.prop_set.attrib =3D 0;
	cmd.prop_set.offset =3D cpu_to_le32(off);
	cmd.prop_set.value =3D cpu_to_le64(val);

	ret =3D __nvme_submit_sync_cmd(ctrl->fabrics_q, &cmd, NULL, NULL, 0,
				     timeout, NVME_QID_ANY, 0, 0);
	if (unlikely(ret))
		dev_err(ctrl->device,
			"Property Set error: %d, offset %#x\n",
			ret > 0 ? ret & ~NVME_SC_DNR : ret, off);
	return ret;
}

Again, please let me know if this solution is acceptable and I will submit =
a patch.

Regards,
Martin Belanger
Engineering Technologist, Dell Inc.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
