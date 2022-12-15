Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8F5DC4332F
	for <linux-nvme@archiver.kernel.org>; Thu, 15 Dec 2022 07:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:References:Content-Type:
	In-Reply-To:MIME-Version:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=mupzPIX2SljVVEf2MaGmqai7ObDT2H6SxmFRHi29TkA=; b=Z+o0T9muc5496+HYmND0pEnsTU
	BgsKXAA1qACEnZdz5n8WjSt1L9STSC6vu+5E72x34fRzH/jAgH4FbQjvPCux6z6b8BIvdMMcd71RW
	AN39AlU3SyUSr9Zbtjj1w6mtYWk35DvlxBjmj/ylmae1m4DTUgHU334fJf1dqZ2oRxtLsz37oVh+H
	+FEXTlBSXLJFBSECjAoqC5M7KJuKngr3oAEwuZ4W5t6QPFYr4OvPhOUvbn0HTHRr6uBn43V/PP50I
	bYbiMJu9iYQajYxY+BKEbD05ar75N3GeWwaelg3Zy2tqhKf+syzEKSWOdHlWVDUu3W5ARNVsTbLxp
	FgVs5WRw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5icp-007CnD-Od; Thu, 15 Dec 2022 07:25:51 +0000
Received: from mailout3.samsung.com ([203.254.224.33])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p5icl-007Cjz-9s
	for linux-nvme@lists.infradead.org; Thu, 15 Dec 2022 07:25:50 +0000
Received: from epcas5p1.samsung.com (unknown [182.195.41.39])
	by mailout3.samsung.com (KnoxPortal) with ESMTP id 20221215072535epoutp03b7c02bbef1119b42244be3049f206fda~w5rcVGXe91035410354epoutp03o
	for <linux-nvme@lists.infradead.org>; Thu, 15 Dec 2022 07:25:35 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout3.samsung.com 20221215072535epoutp03b7c02bbef1119b42244be3049f206fda~w5rcVGXe91035410354epoutp03o
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
	s=mail20170921; t=1671089135;
	bh=mupzPIX2SljVVEf2MaGmqai7ObDT2H6SxmFRHi29TkA=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=PgBGR3SIlIjdzpB/wI7TS0DjNjeXcMBQbrb5jKgjtSmUhrmcUVyHXiyO4X/7SZSle
	 lqpKLtlM7PHDQy8x+QpblxcRiPhBCXx8KZwggv7qiPpB3hebmzF9g46o00EX0AUQD+
	 YuOpkqP25I+WySO6uooxG7y/+HWPTq8yekmhWZS8=
Received: from epsnrtp1.localdomain (unknown [182.195.42.162]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTP id
	20221215072535epcas5p2d7d2c5b4630a27f2d557dfd94907d659~w5rcJ68_s1623816238epcas5p2J;
	Thu, 15 Dec 2022 07:25:35 +0000 (GMT)
Received: from epsmges5p3new.samsung.com (unknown [182.195.38.177]) by
	epsnrtp1.localdomain (Postfix) with ESMTP id 4NXkKV2NtHz4x9QN; Thu, 15 Dec
	2022 07:25:34 +0000 (GMT)
Received: from epcas5p2.samsung.com ( [182.195.41.40]) by
	epsmges5p3new.samsung.com (Symantec Messaging Gateway) with SMTP id
	46.9F.56352.DEBCA936; Thu, 15 Dec 2022 16:25:33 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
	epcas5p2.samsung.com (KnoxPortal) with ESMTPA id
	20221215072533epcas5p2c6d6857a6e90ad299e2a99a81bc18301~w5rZ6DS5L0323803238epcas5p2H;
	Thu, 15 Dec 2022 07:25:33 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
	epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
	20221215072533epsmtrp1bfde8568069e615ac0e004dfef8a9977~w5rZ5ZMJP1021410214epsmtrp1f;
	Thu, 15 Dec 2022 07:25:33 +0000 (GMT)
X-AuditID: b6c32a4b-383ff7000001dc20-12-639acbed8273
Received: from epsmtip1.samsung.com ( [182.195.34.30]) by
	epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
	9E.8B.18644.CEBCA936; Thu, 15 Dec 2022 16:25:33 +0900 (KST)
Received: from test-zns (unknown [107.110.206.5]) by epsmtip1.samsung.com
	(KnoxPortal) with ESMTPA id
	20221215072531epsmtip12c848bc0c2924bae1fe3d2276b389d94~w5rYEdwqN1418514185epsmtip1J;
	Thu, 15 Dec 2022 07:25:30 +0000 (GMT)
Date: Thu, 15 Dec 2022 12:44:05 +0530
From: Kanchan Joshi <joshi.k@samsung.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, Sagi Grimberg <sagi@grimberg.me>,
	Chaitanya Kulkarni <kch@nvidia.com>, linux-nvme@lists.infradead.org
Subject: Re: [PATCH 9/9] nvme: don't allow unprivileged passthrough of
 commands that have effects
Message-ID: <20221215071405.GA27656@test-zns>
MIME-Version: 1.0
In-Reply-To: <20221214161347.764071-10-hch@lst.de>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFmpmk+LIzCtJLcpLzFFi42LZdlhTQ/ft6VnJBrOa5SxWrj7KZDHp0DVG
	i6dXZzFZzF/2lN1i3ev3LA6sHufvbWTx2LSqk81j85J6j903G9g8epvfsQWwRmXbZKQmpqQW
	KaTmJeenZOal2yp5B8c7x5uaGRjqGlpamCsp5CXmptoqufgE6Lpl5gAtV1IoS8wpBQoFJBYX
	K+nb2RTll5akKmTkF5fYKqUWpOQUmBToFSfmFpfmpevlpZZYGRoYGJkCFSZkZ+w45llwS6Li
	2ZMmpgbGfSJdjJwcEgImEsfWLWXuYuTiEBLYzShxpu0WG4TziVFiz78OVgjnM6PEqqd3WGBa
	Zs37xQ6R2MUo0X7tHlT/M0aJq73b2ECqWARUJZbP+Q7UzsHBJqApcWFyKUhYREBJ4umrs4wg
	9cwCPYwS59pXsoIkhAWSJZa+Pglm8wroSjQ+WAplC0qcnPkEbDOngJHElb7F7CC2qICyxIFt
	x5lABkkIfGSXuLLlIhPEeS4SJyd/YYOwhSVeHd/CDmFLSbzsb4OykyUuzTwHVV8i8XjPQSjb
	XqL1VD8zyNHMAhkS9877goSZBfgken8/YQIJSwjwSnS0CUFUK0rcm/SUFcIWl3g4YwmU7SFx
	f0snEyRM1jBKXGhdwziBUW4WkndmIWyYBbbBSqLzQxMrRFhaYvk/DghTU2L9Lv0FjKyrGCVT
	C4pz01OLTQuM81LL4VGcnJ+7iRGcGrW8dzA+evBB7xAjEwfjIUYJDmYlEd79MrOShXhTEiur
	Uovy44tKc1KLDzGaAmNnIrOUaHI+MDnnlcQbmlgamJiZmZlYGpsZKonzLp3SkSwkkJ5Ykpqd
	mlqQWgTTx8TBKdXApMt2+K7PTjUmdrOVdYnnnno3aM2SyeYOq9ff1sbpovZew14xIKrxUbv3
	GoP2IFNml19mWVP52m0Wa85cHrai9X+5xjZx7f9vj+Qyfbt/ViXQK/xhmsFBXSeFhn+eIYkW
	XAp2rp4Wymy8GzZMFlhe9dZh29NV/y41fFF5kKCgWyLqK+hqbWu8td/8rcnq8OIfhg90Mnoc
	ImZq/Voh1d94hF/Ja92Pld0di8/aej6dvu3QptC+tU2uwpyLzzrV6HxdZmnHvLEk6c2lO+0H
	pgWfLg3jFip4sP7XcgaHSbca/0vcvX7/7cNZGfLT652KzstyMF2Iuj6DXeP9JYUdU49ut9xo
	2xnhXXpMfL2Q7BYlluKMREMt5qLiRADst3E7FgQAAA==
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFrrCLMWRmVeSWpSXmKPExsWy7bCSnO7b07OSDW58YrJYufook8WkQ9cY
	LZ5encVkMX/ZU3aLda/fsziwepy/t5HFY9OqTjaPzUvqPXbfbGDz6G1+xxbAGsVlk5Kak1mW
	WqRvl8CVsffoTMaCHrGKHY1X2BsYu4S6GDk5JARMJGbN+8XexcjFISSwg1Hi0LPtLBAJcYnm
	az/YIWxhiZX/nkMVPWGUOLmmlwkkwSKgKrF8znfWLkYODjYBTYkLk0tBwiICShJPX51lBKln
	FuhhlDjXvpIVJCEskCyx9PVJMJtXQFei8cFSVoihaxgl7k2eA5UQlDg58wnYFcwCZhLzNj9k
	BlnALCAtsfwfB0iYU8BI4krfYrDjRAWUJQ5sO840gVFwFpLuWUi6ZyF0L2BkXsUomVpQnJue
	W2xYYJSXWq5XnJhbXJqXrpecn7uJERzwWlo7GPes+qB3iJGJg/EQowQHs5II736ZWclCvCmJ
	lVWpRfnxRaU5qcWHGKU5WJTEeS90nYwXEkhPLEnNTk0tSC2CyTJxcEo1MF3MnOqdc3uKAOe5
	Bxn3n3mvU9paUmedGMStf/YPI/+pT1/We9jz/eB3zS/0sC1UbIpbrfXrP4u68Swdqcjg4+Kb
	9P8sf5tW8Un07zexHK2Aovu9e7njsjfoV53+1BF/M2R/cS1rUUClkAVPdHuG8uVd7lsqW4wq
	jopOvmGTJh936sGTAj+1hI2/Pmmf1uHl+by40a74jmjFmettDdb+S5Zpxe7tkJPS6W40L05U
	cD957VPhreflKUo/eS4uFpu6+4aTxfz5+48qB2of2C93YXWkxPTze4Qfd3+KreY4uudLeNpl
	s29LGDvcXMrfZV6MutRzaPtpf/k7r62YuI83n7lu81b20AaHK1s+TUvkV2Ipzkg01GIuKk4E
	AEsQRvHnAgAA
X-CMS-MailID: 20221215072533epcas5p2c6d6857a6e90ad299e2a99a81bc18301
X-Msg-Generator: CA
Content-Type: multipart/mixed;
	boundary="----d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_35d6a_"
CMS-TYPE: 105P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20221214161926epcas5p49ec1cfa4cdc583b00bf6b8b066eb1964
References: <20221214161347.764071-1-hch@lst.de>
	<CGME20221214161926epcas5p49ec1cfa4cdc583b00bf6b8b066eb1964@epcas5p4.samsung.com>
	<20221214161347.764071-10-hch@lst.de>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221214_232548_018037_A11A0483 
X-CRM114-Status: GOOD (  20.13  )
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

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_35d6a_
Content-Type: text/plain; charset="utf-8"; format="flowed"
Content-Disposition: inline

On Wed, Dec 14, 2022 at 05:13:47PM +0100, Christoph Hellwig wrote:
>Commands like Write Zeros can change the contents of a namespaces without
>actually transferring data.  To protect against this check the Commands
>Supported and Effects log and refuse unprivileged passthrough if the
>command has any effects.  This also includes more intrusive effects which
>currently can't happen for I/O commands.
>
>Fixes: e4fbcf32c860 ("nvme: identify-namespace without CAP_SYS_ADMIN")
>Signed-off-by: Christoph Hellwig <hch@lst.de>
>---
> drivers/nvme/host/ioctl.c | 15 ++++++++-------
> 1 file changed, 8 insertions(+), 7 deletions(-)
>
>diff --git a/drivers/nvme/host/ioctl.c b/drivers/nvme/host/ioctl.c
>index a371209ee5e6d4..90e3a4a711bd17 100644
>--- a/drivers/nvme/host/ioctl.c
>+++ b/drivers/nvme/host/ioctl.c
>@@ -11,6 +11,8 @@
> static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
> 		fmode_t mode)
> {
>+	u8 opcode = c->common.opcode;
>+
> 	if (capable(CAP_SYS_ADMIN))
> 		return true;
>
>@@ -18,8 +20,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
> 	 * Do not allow unprivileged processes to send vendor specific or fabrics
> 	 * commands as we can't be sure about their effects.
> 	 */
>-	if (c->common.opcode >= nvme_cmd_vendor_start ||
>-	    c->common.opcode == nvme_fabrics_command)
>+	if (opcode >= nvme_cmd_vendor_start || opcode == nvme_fabrics_command)
> 		return false;
>
> 	/*
>@@ -29,7 +30,7 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
> 	 * potentially sensitive information.
> 	 */
> 	if (!ns) {
>-		if (c->common.opcode == nvme_admin_identify) {
>+		if (opcode == nvme_admin_identify) {
> 			switch (c->identify.cns) {
> 			case NVME_ID_CNS_NS:
> 			case NVME_ID_CNS_CS_NS:
>@@ -43,11 +44,11 @@ static bool nvme_cmd_allowed(struct nvme_ns *ns, struct nvme_command *c,
> 	}
>
> 	/*
>-	 * Only allow I/O commands that transfer data to the controller if the
>-	 * special file is open for writing, but always allow I/O commands that
>-	 * transfer data from the controller.
>+	 * Only allow I/O commands that transfer data to the controller, change
>+	 * the logical block content or have any other intrusive effects if the
>+	 * special file is open for writing.

nit: trailing whitespace at the end of above line.

> 	 */
>-	if (nvme_is_write(c))
>+	if (nvme_is_write(c) || nvme_command_effects(ns->ctrl, ns, opcode))
> 		return mode & FMODE_WRITE;

So even for operation that do not alter anything (e.g. nvme_cmd_read)
nvme_is_write will return false, but nvme_command_effects will return
true and we will ask for FMODE_WRITE. Is that intentional?

I think doing 
"nvme_command_effects(ctrl, ns, opcode) & ~NVME_CMD_EFFECTS_CSUPP"
is better to avoid that?

------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_35d6a_
Content-Type: text/plain; charset="utf-8"


------d7wgNpQcY-y3Wxr.o4x8P.ZM-s8jhIouQULCgAQexljrVMsg=_35d6a_--

