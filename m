Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2370C88CB2
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Aug 2023 01:41:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Reply-To:List-Subscribe:
	List-Help:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:
	Mime-Version:Message-Id:Subject:To:From:Date:Cc:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=TbyDmJrV3LB/81t3aostJTKQK/giBC5p28d06yRmM+k=; b=htPtalewb7gsWLluDK8wE5Pfrg
	oswBUjAb2h9b/VCyk1RWLt2BqRBVCz1BbPQe6JlgXuSfjt/0h0+z5yxGsTNWyS44WH1P3oTMJ+2Jx
	wnTtPKnGkwIJrmtcUAg3EnEmZ59JSylCcIOsw6lWXNGcdQSn6/GnTDi3jf1UGkbyejlg2N5qqBkfJ
	GInaD3qB4m0SAJfEPHbzrFSkAYwJV44dMP7qsfdFDxerDLiig5R3vM80uNX1cM2ckT496/FVCwg6Y
	1wCxSbszb16oYGv40nqRS1d3urmrxyYBqg8erWcH6mRlcKaF0GV6f42gKriYmGZvrUDZ/kW9BRtgi
	37bOXs4g==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qZLpX-0045Hc-19;
	Fri, 25 Aug 2023 01:41:43 +0000
Received: from wout2-smtp.messagingengine.com ([64.147.123.25])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qZLpU-0045Gb-17
	for linux-nvme@lists.infradead.org;
	Fri, 25 Aug 2023 01:41:42 +0000
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
	by mailout.west.internal (Postfix) with ESMTP id 2AC973200976;
	Thu, 24 Aug 2023 21:41:30 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Thu, 24 Aug 2023 21:41:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pragmasoft.com;
	 h=cc:content-type:content-type:date:date:from:from:in-reply-to
	:message-id:mime-version:reply-to:reply-to:sender:subject
	:subject:to:to; s=fm2; t=1692927689; x=1693014089; bh=TbyDmJrV3L
	B/81t3aostJTKQK/giBC5p28d06yRmM+k=; b=vn0g39kAzlNQK5zf8wxyFkq+Hx
	/lLTz+1emUTpQuaLMbVkuZ+z+EhOE+HW7hZtQNwLaU6jvQk0yAqeyOv9WzOQxiCG
	1RiYtLR+bpgnlfaQ/ijbAHRME9ieAAMK18ViNw2VukOb+vakWqCFpydPb+dcco4A
	57/LRzFom75yzd9p+QacEdN+R1Hzq1/OoalXOp/zOub9Ze25NYCeesvnBe7khBSC
	1ryxeCghgChR72YZhBUN27jO2rchM/ZBgcTt8yHfoKTvCJvQDT0j/yObP/YD7vrm
	iFseUFRG0XsIygZz+1Hb5MaaOTudKT46crQmijhKRLJN+coFueIrfpksD1MQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
	messagingengine.com; h=cc:content-type:content-type:date:date
	:feedback-id:feedback-id:from:from:in-reply-to:message-id
	:mime-version:reply-to:reply-to:sender:subject:subject:to:to
	:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
	fm1; t=1692927689; x=1693014089; bh=TbyDmJrV3LB/81t3aostJTKQK/gi
	BC5p28d06yRmM+k=; b=FUJqFTM6Z8xqVSTFfoaDW9DoCTa5r+uNz3mF0ce+tsfM
	I3PH4ZCJF5J24/ICe5U3yRK0bhGEf86J7jJzQZHW5gqkBhpDfCneMY/r2H9XuhQR
	19jejtIgL+Bo6K6UOH8SXOd5RWGdlIBRbQYpgcNRyeEP9hzj7SEL8mPQOLjvgLwR
	X/dxi1PA98ASUy/f02QI5Fsb3fB4AinUj7+ZR0uxlJqeZtdF6Utr4FRNQiqNyqfb
	8LOOCNoYKDCQPs5vVSdZK6yiT10qQmPYhVfGG6qnZub90bWwcd+TAWOQje2zM5Xd
	x9TVz0LvS9tWzAepV37xZjBZlbgy0fuSurivCYaY8Q==
X-ME-Sender: <xms:yQboZDyC6H9327KPbxhiuB2BYK9mOgUtremIqjzkQjRCgfHG-4EQrQ>
    <xme:yQboZLR3R7rim3e3_nldwkIbIAsbf56rOs7oLwt4obqLMBLmBEe9zMyemF534LhvY
    u09seepWfh4wSJ1sfY>
X-ME-Received: <xmr:yQboZNUHSu_jCi_7kvyCUOitEfzjLvyZV3fKVy7iyu4OtrPL7blbDiRGbwbl3NJyiA_RiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedviedruddvjedggeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpeffhffvuffkrhfogggtsehmtderre
    fjtddvnecuhfhrohhmpegrlhhsrghushgvrhesphhrrghgmhgrshhofhhtrdgtohhmnecu
    ggftrfgrthhtvghrnhepffehudeivdekveevvdeludetteeihedvveeigedutefhieegge
    egkeeitdehiefgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhf
    rhhomheprghlshgruhhsvghrsehprhgrghhmrghsohhfthdrtghomh
X-ME-Proxy: <xmx:yQboZNgfzpjywpeEW2inO6ZpQcqWDs6AG8b6s5drCQL9ev0aCuqEqw>
    <xmx:yQboZFBjwycbfl4l3vZzMVX3gybUQULtHp6bn2Nrij7GclMNnCyChA>
    <xmx:yQboZGLFEeiPbdqTlLoIPBTdP5gvQ35e_IfdFCMhr97YSQrIx3uIHQ>
    <xmx:yQboZA9tV-91oEmzoDTq6VqJ04MmZ_x2qcxBnkRQ2tbwEDpKYk2z2Q>
Feedback-ID: if5414767:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA for
 <linux-nvme@lists.infradead.org>; Thu, 24 Aug 2023 21:41:29 -0400 (EDT)
Date: Thu, 24 Aug 2023 21:41:28 -0400
From: alsauser@pragmasoft.com
To: linux-nvme@lists.infradead.org
Subject: Corsair MP600 PRO LPX - SUBNQN and NVME_ID_CNS_CS_CTRL
Message-Id: <20230824214128.f9fb8b6a3ff26bf9d0629e57@pragmasoft.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: multipart/mixed;
 boundary="Multipart=_Thu__24_Aug_2023_21_41_28_-0400_u6IEqNG4H_L6BfKP"
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230824_184140_837929_FA0606C0 
X-CRM114-Status: GOOD (  10.18  )
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
Reply-To: alsauser@pragmasoft.com
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

This is a multi-part message in MIME format.

--Multipart=_Thu__24_Aug_2023_21_41_28_-0400_u6IEqNG4H_L6BfKP
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

I have identified two issues with the Corsair MP600 PRO LPX 4TB M.2 SSD in my Debian Bookworm (12.2.0) system:

1. From syslog:

2023-08-24T20:51:33.193726-04:00 <hostname redacted> kernel: [    1.744108] nvme nvme0: missing or invalid SUBNQN field.

I believe that the attached proposed patch "addresses" this issue.

2. By inserting "printk's", I have concluded that the device does not support the NVME_ID_CNS_CS_CTRL request, more specifically as issued by function nvme_init_non_mdts_limits in drivers/nmve/host/core.c.  Unfortunately, this request results in an additional error in the device's error log on each system reboot, as evidenced by the error log below :(

It appears that recent versions of core.c include a "NVME_CTRL_SKIP_ID_CNS_CS" flag, but I don't see a "quirk" that is able to set that flag and thus avoid the errors on every reboot.

From assorted web searches, it also appears that there might be a recommendation to include the NVME_QUIRK_DISABLE_WRITE_ZEROES option for this drive.   Unfortunately, I do not have any contacts at Corsair or Phison to clarify/pursue/resolve these issues.  Any additional guidance would be appreciated.

Thanks, Scott.

A: As per "lspci -nn":

02:00.0 Non-Volatile memory controller [0108]: Phison Electronics Corporation E18 PCIe4 NVMe Controller [1987:5018] (rev 01)


B: As per "nvme error-log /dev/nmve0":

Error Log Entries for device:nvme0 entries:63
.................
 Entry[ 0]   
.................
error_count	: 281
sqid		: 0
cmdid		: 0
status_field	: 0x2002(Invalid Field in Command: A reserved coded value or an unsupported value in a defined field)
phase_tag	: 0
parm_err_loc	: 0x28
lba		: 0
nsid		: 0
vs		: 0
trtype		: The transport type is not indicated or the error is not transport related.
cs		: 0
trtype_spec_info: 0
.................


C: As per "nvme id-ctrl /dev/nvme0"

NVME Identify Controller:
vid       : 0x1987
ssvid     : 0x1987
sn        : 231079700001314300EF
mn        : Corsair MP600 PRO LPX                   
fr        : EIFM31.6
rab       : 1
ieee      : 6479a7
cmic      : 0
mdts      : 9
cntlid    : 0x1
ver       : 0x10400
rtd3r     : 0x989680
rtd3e     : 0x989680
oaes      : 0x200
ctratt    : 0x2
rrls      : 0
cntrltype : 1
fguid     : 00000000-0000-0000-0000-000000000000
crdt1     : 0
crdt2     : 0
crdt3     : 0
nvmsr     : 0
vwci      : 0
mec       : 0
oacs      : 0x17
acl       : 3
aerl      : 3
frmw      : 0x12
lpa       : 0x8
elpe      : 62
npss      : 4
avscc     : 0x1
apsta     : 0x1
wctemp    : 357
cctemp    : 362
mtfa      : 100
hmpre     : 0
hmmin     : 0
tnvmcap   : 4,000,787,030,016
unvmcap   : 0
rpmbs     : 0
edstt     : 10
dsto      : 0
fwug      : 1
kas       : 0
hctma     : 0x1
mntmt     : 313
mxtmt     : 352
sanicap   : 0
hmminds   : 0
hmmaxd    : 0
nsetidmax : 0
endgidmax : 0
anatt     : 0
anacap    : 0
anagrpmax : 0
nanagrpid : 0
pels      : 0
domainid  : 0
megcap    : 0
sqes      : 0x66
cqes      : 0x44
maxcmd    : 512
nn        : 1
oncs      : 0x5d
fuses     : 0
fna       : 0
vwc       : 0x7
awun      : 255
awupf     : 0
icsvscc   : 1
nwpc      : 0
acwu      : 0
ocfs      : 0
sgls      : 0
mnan      : 0
maxdna    : 0
maxcna    : 0
subnqn    : 
ioccsz    : 0
iorcsz    : 0
icdoff    : 0
fcatt     : 0
msdbd     : 0
ofcs      : 0
ps      0 : mp:8.80W operational enlat:0 exlat:0 rrt:0 rrl:0
            rwt:0 rwl:0 idle_power:- active_power:-
            active_power_workload:-
ps      1 : mp:7.10W operational enlat:0 exlat:0 rrt:1 rrl:1
            rwt:1 rwl:1 idle_power:- active_power:-
            active_power_workload:-
ps      2 : mp:5.20W operational enlat:0 exlat:0 rrt:2 rrl:2
            rwt:2 rwl:2 idle_power:- active_power:-
            active_power_workload:-
ps      3 : mp:0.0620W non-operational enlat:2500 exlat:7500 rrt:3 rrl:3
            rwt:3 rwl:3 idle_power:- active_power:-
            active_power_workload:-
ps      4 : mp:0.0440W non-operational enlat:10500 exlat:65000 rrt:4 rrl:4
            rwt:4 rwl:4 idle_power:- active_power:-
            active_power_workload:-

--Multipart=_Thu__24_Aug_2023_21_41_28_-0400_u6IEqNG4H_L6BfKP
Content-Type: text/x-diff;
 name="Corsair_MP600_4TB.patch"
Content-Disposition: attachment;
 filename="Corsair_MP600_4TB.patch"
Content-Transfer-Encoding: 7bit

--- a/drivers/nvme/host/pci.c	2023-07-05 13:27:38.000000000 -0400
+++ b/drivers/nvme/host/pci.c	2023-08-20 15:34:58.272933870 -0400
@@ -3476,6 +3476,8 @@
 	{ PCI_DEVICE(0x1987, 0x5016),	/* Phison E16 */
 		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN |
 				NVME_QUIRK_BOGUS_NID, },
+	{ PCI_DEVICE(0x1987, 0x5018),	/* Phison E18 */
+		.driver_data = NVME_QUIRK_IGNORE_DEV_SUBNQN, },
 	{ PCI_DEVICE(0x1987, 0x5019),  /* phison E19 */
 		.driver_data = NVME_QUIRK_DISABLE_WRITE_ZEROES, },
 	{ PCI_DEVICE(0x1987, 0x5021),   /* Phison E21 */

--Multipart=_Thu__24_Aug_2023_21_41_28_-0400_u6IEqNG4H_L6BfKP--

