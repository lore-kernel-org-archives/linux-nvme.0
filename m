Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E1B6DCDD0FF
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Oct 2024 23:03:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:MIME-Version:Message-ID:Subject:From:To:Date:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=w/lTpzuSprxlCOOf3gYwuEUMMWZYwHaPg86FiRB2ai8=; b=WJvKTSGboFvAThd6nFpQK2nu9i
	fuGKV3jWFApy2CboYFLWW05mN3TL24OD1CoeXJSkgrjKDjriMOL/H0Hr2Alb9/h/Z0pY2lt3uDFQ8
	9oxZ0V6D2W/W2eLTzsHWakHlLm1PCFXjq4hW+9ZyaF4AgnBLGU1D/XkAPrXDYK3AXZc8n/iwzcYo5
	UTujyZRGC9nYHBNB3wGRgOUOJyaMiXr63kafBbmGqh1/ahpYs263CDo9kA2RZZr9YNnVZKIpuxiTw
	GiTRzfqUABoj6Fkx/0dJWFQyetryqiToC4dNOP647W5O7Oulu2/2sMV1wosUGmuBYqPCvCDqWUfWm
	cMqKp/Uw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1t3NuU-0000000COlM-3Xro;
	Tue, 22 Oct 2024 23:03:30 +0000
Received: from mail-40132.protonmail.ch ([185.70.40.132])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1t3NuR-0000000COkg-0tHh
	for linux-nvme@lists.infradead.org;
	Tue, 22 Oct 2024 23:03:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
	s=protonmail; t=1729638202; x=1729897402;
	bh=w/lTpzuSprxlCOOf3gYwuEUMMWZYwHaPg86FiRB2ai8=;
	h=Date:To:From:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
	 Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
	b=KkbetsHGsZZkXhFbyCY+ucfSjHh8s/uznaQpz9SOc+IsRdXljn3Gkfb6DOEzXWBy9
	 gOZpJ/m6VBxEUiiQNPSDOFhUdpTtSt7EVfgVwCLi6D9/HlCOAZZut09y0jzK6A/E+T
	 idTDq3JFa0cEcKOX4U8Y8cGqZB+pzusdHFmMKUKItQcdJgVfzY8u22N2sW1LE3sohD
	 RTsRmlbFj5Acx3ZhnXQER5OAWTL+N/Lohk8rqMOeNXcN6Bq/mj3VfuYA+24tkNEguw
	 stIEmpoUWZF7PKTqSeRKGqXR+DdZGAyx+ybLfw2iy3Y/aMqgePYrCMcmNy2RFtCrFA
	 /f4zyh/PhyWlA==
Date: Tue, 22 Oct 2024 23:03:18 +0000
To: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
From: pallas wept <pallaswept@proton.me>
Subject: x2002 Errors from Corsair P3 Plus
Message-ID: <jvHjYW6DhvfuRsFL46GsoefGgOwF5IWcmq0u1UPhMbrALDMj6935K31Zyl_dHKz3WIuO4Fb5NSkTLJT01xD3TA3Rh9XsHPuPaNrVxC2AiIQ=@proton.me>
Feedback-ID: 45493025:user:proton
X-Pm-Message-ID: 3c05aae24d2e0476344246a2ceace784f57c18d4
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241022_160328_032303_CC196746 
X-CRM114-Status: UNSURE (   6.64  )
X-CRM114-Notice: Please train this message.
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
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi list,=20
I hope you can help.

I was quite concerned to see SMART errors from my brand new SSD this mornin=
g:

    > sudo nvme error-log /dev/nvme1
    Error Log Entries for device:nvme1 entries:16
    .................
    =C2=A0Entry[ 0]
    .................
    error_count =C2=A0 =C2=A0 : 13
    sqid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    cmdid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0xa005
    status_field =C2=A0 =C2=A0: 0x2002(Invalid Field in Command: A reserved=
 coded value or an unsupported value in a defined field)
    phase_tag =C2=A0 =C2=A0 =C2=A0 : 0x1
    parm_err_loc =C2=A0 =C2=A0: 0x4
    lba =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0
    nsid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0x1
    vs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    trtype =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: The transport type is not in=
dicated or the error is not transport related.
    csi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0
    opcode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    cs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    trtype_spec_info: 0
    log_page_version: 0
    .................
    =C2=A0Entry[ 1]
    .................
    error_count =C2=A0 =C2=A0 : 12
    sqid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    cmdid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0xa004
    status_field =C2=A0 =C2=A0: 0x2002(Invalid Field in Command: A reserved=
 coded value or an unsupported value in a defined field)
    phase_tag =C2=A0 =C2=A0 =C2=A0 : 0x1
    parm_err_loc =C2=A0 =C2=A0: 0x4
    lba =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0
    nsid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0x1
    vs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    trtype =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: The transport type is not in=
dicated or the error is not transport related.
    csi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0
    opcode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    cs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    trtype_spec_info: 0
    log_page_version: 0
    .................
    =C2=A0Entry[ 2]
    .................
    error_count =C2=A0 =C2=A0 : 11
    sqid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    cmdid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0x18
    status_field =C2=A0 =C2=A0: 0x2002(Invalid Field in Command: A reserved=
 coded value or an unsupported value in a defined field)
    phase_tag =C2=A0 =C2=A0 =C2=A0 : 0x1
    parm_err_loc =C2=A0 =C2=A0: 0x28
    lba =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0
    nsid =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    vs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    trtype =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: The transport type is not in=
dicated or the error is not transport related.
    csi =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 : 0
    opcode =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    cs =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0 =C2=A0: 0
    trtype_spec_info: 0
    log_page_version: 0
    .................
   =20

I've searched about this and I understand that these errors are nothing to =
worry about directly, but I also gather that for some devices, there was a =
means to avoid these errors being logged. I saw some discussion of a 'quirk=
s' database? I'm wondering if maybe the same could be done for these device=
s also? They're quite popular, being Amazon's recommended NVMe drive, so ma=
ybe it's worth it.

Advice from github https://github.com/linux-nvme/nvme-cli/issues/2540#issue=
comment-2430454238
suggested that I provide PCI IDs, would this help?:

08:00.0 Non-Volatile memory controller [0108]: Micron/Crucial Technology P3=
 Plus NVMe PCIe SSD (DRAM-less) [c0a9:5421] (rev 01)


Presuming that I have correctly interpreted the issues here and nothing is =
really wrong, my goal here is to get a clean log when nothing is wrong, so =
that genuine errors would not be hidden behind the 'noise' of spurious erro=
rs.

Thanks for any advice you could offer.

