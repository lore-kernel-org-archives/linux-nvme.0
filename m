Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04167C001E0
	for <linux-nvme@archiver.kernel.org>; Mon, 31 Jul 2023 19:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-transfer-encoding:
	Content-type:In-reply-to:From:References:Cc:To:Subject:MIME-version:Date:
	Message-id:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MmCddPORwyGMhO45TLDEY2+Z5G9cWBHInOBlZ2EgK9M=; b=Okxh8hPLbZtlZZB8KfTPuOM9XI
	mu6E9UXjg9BfYH9j6HNcsShpfXO52Ya08s4HaSlFOtonxl/Mc1taYFvIgNRqxDPUeLjy6jvzMogQp
	gHrBxTmx/IFx45F0U1oV/nYDplubdXOIZGH8eWHmLrAsb3O43J1dynRaQ1/954bNJxkrhWfM0yt7j
	+Mhtys6xz8/9fuyPgZUEJ2BHjUnPKwbcMd0XDJpRNbGlravqD/uYU28O3oCABkiLI4fI1atHtZlhZ
	AbUxXP0lQ3Hx2fP2gHKM1eRoXy43q5t4ALmTeXoCFfdL6WiQUTP00i3dO0bYsw1NzWEKTqRzBQe3D
	QcTaQSrg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYJ8-00H4vG-1H;
	Mon, 31 Jul 2023 19:11:54 +0000
Received: from abi149hd127.arn1.oracleemaildelivery.com ([129.149.84.127])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qQYJ4-00H4sM-1u
	for linux-nvme@lists.infradead.org;
	Mon, 31 Jul 2023 19:11:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=oci-arn1-20220924;
 d=augustwikerfors.se;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=MmCddPORwyGMhO45TLDEY2+Z5G9cWBHInOBlZ2EgK9M=;
 b=b+QZdO5nLgMToo/z44/aBqv0i2xQxJTKUg2c5qWJJRj+LCHtv1rmNbL6jxRDfTMbtQT0iwp8KAP0
   tps7jRXmQTapWB8XemrrP4/jOxkgT9eMoBEtT1QYPVaT5gGSvCn8mPs0fgTugqP/FbI8muDODuy+
   1KELF9pyOXlEXStx9grRSrxy8iLX2Qo9h1RFwhN4bk/1xHG5ClgbjpWa6hL0jTV2e63qeX6e/e5t
   rnNdK1JG/OgCOUSVw1rtkZ9OaoslBByyUxDErvOntlkv0O2fnPEAcFhdQuv4rfIu62rpdeBRlMC6
   R1gihbJzWlIrYi9TulOwZkG5QgqSpFj9oW2Jhg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; s=prod-arn-20211201;
 d=arn1.rp.oracleemaildelivery.com;
 h=Date:To:From:Subject:Message-Id:MIME-Version:Sender;
 bh=MmCddPORwyGMhO45TLDEY2+Z5G9cWBHInOBlZ2EgK9M=;
 b=TRbvF8hWn7Xh6ptKQQgYS7x7RnL6UoTfD6soA36LaLtiRMTeSrTcBtCEHN3RjiyoNb4dgBu1iMYN
   g1tBWmpJe5DwXMAVJdHBEjW6aaEUyPFk5KgPLvaP5rDy736vH/hB+4Oy7L5vLwvZoT/x8fm2hM4C
   hpK5230IrYTSCwZ5gkLrlLjqmsuMwLjURvJ9Is8+ymsQv26V9Um/jadsO+ZQCaTmxrx40GzYnP2W
   JShZO3S4XHhYbwf48t4Tpxr90s8oyebid2UvLtBLrU35zOBhXe8K0r/A1nvCGboDo4BzIrEcYX/d
   7h3un4jHiQIUrDfubASib5QHeSqOBWO9Bhgi0w==
Received: by omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com
 (Oracle Communications Messaging Server 8.1.0.1.20230629 64bit (built Jun 29
 2023))
 with ESMTPS id <0RYO006WYDBIMKD0@omta-ad1-fd2-401-eu-stockholm-1.omtaad1.vcndparn.oraclevcn.com>
 for linux-nvme@lists.infradead.org; Mon, 31 Jul 2023 19:11:42 +0000 (GMT)
Message-id: <40058d79-7363-9474-2af0-b8e02b7b01ab@augustwikerfors.se>
Date: Mon, 31 Jul 2023 21:11:39 +0200
MIME-version: 1.0
Subject: Re: [PATCH] nvme: Don't fail to resume if NSIDs change
Content-language: en-US
To: Mario Limonciello <mario.limonciello@amd.com>
Cc: kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 nilskruse97@gmail.com, David.Chang@amd.com
References: <20230731185103.18436-1-mario.limonciello@amd.com>
From: August Wikerfors <git@augustwikerfors.se>
In-reply-to: <20230731185103.18436-1-mario.limonciello@amd.com>
Content-type: text/plain; charset=UTF-8; format=flowed
Content-transfer-encoding: 7bit
Reporting-Meta: AAGxKd0J+EDPNkJxyVSwXV8t9u0oYmwvO47EmDb/N7KkuuHQNewGDNL7XqL4XvXk
 NwsfeuoNmYe+xIBGUiBthWydppa6afCXI4mhI1ZAhVj9tUfqsehwVZ7eDWrWiIRg
 MOGw0MOUzQdELbqmXNflVFW6vNqyeYw0LWpasbkm37ElLokqbzDaIJqCuEq/bzQ8
 wfXBvM5EmybykvaIwvP82s8t+ewKen2Di0gKYHB8XeKBVFWMrYgvxRRbQaQ1q4GM
 plqqquF2cjZxxS/X17Xv/CEKWnlE/UQCt+IBFznppXRGjQ0T0hw+zvzyAC31KJKB
 Rciv7Q83o0pzLVMIRPpgf9T6BK3sT3P20XjjWxwuz0T2s6Xqp2UoTAirF+bqWMMl
 A37kYf7CK7EZ7aQXZ1aW/aTCvvnBywGNVRieA+9V6F/qhRXMne9rkqDZMjqYo/jT chjel6/SMw==
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230731_121151_216450_1483B452 
X-CRM114-Status: GOOD (  10.13  )
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

On 2023-07-31 20:51, Mario Limonciello wrote:
> Samsung PM9B1 has problems after resume because NSID has changed.
> This has been reported in the past on OEM varities of PM9B1 parts
> and fixed by firmware updates on 'some' of those parts.
> 
> However this same issue also happens on 'retail' PM9B1 parts which
> Samsung has not released firmware updates for.
> 
> As the check has been relaxed at startup for multiple disks with
> duplicate NSIDs with commit ac522fc6c3165 ("nvme: don't reject
> probe due to duplicate IDs for single-ported PCIe devices") also
> relax the check that runs on resume for NSIDs and mark them bogus
> if this occurs on resume.
> 
> Fixes: 1d5df6af8c74 ("nvme: don't blindly overwrite identifiers on disk revalidate")
> Cc: stable@vger.kernel.org # 6.1+
> Cc: Nils Kruse <nilskruse97@gmail.com>
> Cc: August Wikerfors <git@augustwikerfors.se>
> Cc: David Chang <David.Chang@amd.com>
> Link: https://github.com/tomsom/yoga-linux/issues/9
> Link: https://lore.kernel.org/linux-nvme/b99a5149-c3d6-2a9b-1298-576a1b4b22c1@gmail.com/
> Link: https://lore.kernel.org/all/20221116171727.4083-1-git@augustwikerfors.se/t/
> Link: https://lore.kernel.org/all/d0ce0f3b-9407-9207-73a4-3536f0948653@augustwikerfors.se/
> Signed-off-by: Mario Limonciello <mario.limonciello@amd.com>
Tested-by: August Wikerfors <git@augustwikerfors.se>

Thanks!

