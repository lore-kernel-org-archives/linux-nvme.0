Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 93988C6FD1C
	for <linux-nvme@archiver.kernel.org>; Wed, 22 Mar 2023 11:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Type:MIME-Version:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-Transfer-Encoding:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=xVHrCBSHqQ3+J2oHuVoZ4w6JEJsP/NKWww77tlClRIc=; b=ILTJVQh+yn9jIYohGVh1XjA46A
	sXC2+TntgAcfSZWC0s4fWBCSceFh/QsnFK86ow0MrHZNC8/d3ccc/+HPlpa6HPNXnDaA09dez1nVG
	YqMz7T0CWaX+gkQH8CbxbGXojCyTd9NPyl89m0+jqcoTS1mU0VKRkAvgt2IqNm74AqzTV073qIqSy
	6NPWIMRVulcu3zFjiB/ZRC9aTpaHkJT5DzWD7thIlvcRXaxto2rxuFZy8D22zYdfS2HNddYn08YZ0
	rWY63RK15SZCBDDzeJYid2in2znGhqNi62LhFJZRcVANR/ALZeq579FW4rEAWGDCw+zCc+cQ0Yr7B
	3x9vdXzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1pewUp-00FkYh-29;
	Wed, 22 Mar 2023 11:19:11 +0000
Received: from mail.skyhub.de ([2a01:4f8:190:11c2::b:1457])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1pewUm-00FkVQ-0i
	for linux-nvme@lists.infradead.org;
	Wed, 22 Mar 2023 11:19:10 +0000
Received: from zn.tnic (p5de8e687.dip0.t-ipconnect.de [93.232.230.135])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 368EB1EC0622;
	Wed, 22 Mar 2023 12:19:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
	t=1679483940;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=xVHrCBSHqQ3+J2oHuVoZ4w6JEJsP/NKWww77tlClRIc=;
	b=lcSW4XpEVwRxOyvWvReKmGwwuVSE0iUO2ddSKcUZA8YGQnYLZLX1wtILxRqRQWIm7voOQm
	XaQuUT+hMr9VGfELaGjMOepduYVmY0YHipDV0OtikxlLyLpeDirf72wSb7CEWpp6DRB7pR
	TfFSn7wLuBwIX+XJaP+/sXD7nYiie0g=
Date: Wed, 22 Mar 2023 12:18:59 +0100
From: Borislav Petkov <bp@alien8.de>
To: linux-nvme@lists.infradead.org
Cc: 8bitw35@gmail.com
Subject: [bugzilla-daemon@kernel.org: [Bug 217227] New: Dual NVMe from same
 manufacturer ID collision.]
Message-ID: <20230322111859.GAZBrkI6CF/SGlRp/F@fat_crate.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230322_041908_436236_8CDD6C00 
X-CRM114-Status: GOOD (  13.78  )
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

I don't think linux-nvme is present on bugzilla so forwarding it to the
ML.

----- Forwarded message from bugzilla-daemon@kernel.org -----

Date: Wed, 22 Mar 2023 02:37:03 +0000
From: bugzilla-daemon@kernel.org
To: bp@alien8.de
Subject: [Bug 217227] New: Dual NVMe from same manufacturer ID collision.
Message-ID: <bug-217227-6385@https.bugzilla.kernel.org/>

https://bugzilla.kernel.org/show_bug.cgi?id=217227

            Bug ID: 217227
           Summary: Dual NVMe from same manufacturer ID collision.
           Product: Platform Specific/Hardware
           Version: 2.5
    Kernel Version: 6.2.7
          Hardware: Intel
                OS: Linux
              Tree: Mainline
            Status: NEW
          Severity: normal
          Priority: P1
         Component: x86-64
          Assignee: platform_x86_64@kernel-bugs.osdl.org
          Reporter: 8bitw35@gmail.com
        Regression: No

I was told to report this issue here. The patch to fix the issue is in the
cited reference. 

Summary: 
Using two NVMe drives with the same make/model installed on the same
motherboard will cause ID collision, and will not allow mounting/booting of one
or the other. 

References: 
https://bbs.archlinux.org/viewtopic.php?id=283304

-- 
You may reply to this email to add a comment.

You are receiving this mail because:
You are watching the assignee of the bug.

----- End forwarded message -----

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

