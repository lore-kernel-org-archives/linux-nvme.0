Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83B9BC433FE
	for <linux-nvme@archiver.kernel.org>; Tue, 18 Oct 2022 20:22:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:To:Subject:From:MIME-Version:Date:Message-ID:Reply-To:Cc:
	Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
	Resent-To:Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Owner;
	bh=j8mynyvarlC35qJfKblW1Aebw6sroIa49EYK/nv3Nu0=; b=JVyOhZj3cDaJbJnUWLLs3DtLPP
	GolS2BbUec+qsDJ9MGOn3wwv5Ni6xgFRqEbccL6VlX4rrUPjrzvD8MtdO97aKSXirspO0gfEx6QuL
	8jhFE+1TlcSOOtZSLG2fSUMQPyXNjNFzX1jKFn81b5duOSrJStldxQvYGBxjJWx0H1CNPAL1URAq1
	9FwMYV1a/tMcfgyrnBBW0pX2WqF92QymtilWr02YUS4OI8UbZ6oGLqtIrN1yl4drgOUSwo8zyu8Yx
	nX1lihhsFi5uI/lLg4Q+TW6eV1gb1JgsEoxAo/qOVveOsLStDpY4C095mAf5fbGTnlmfZjxbsTraq
	+U9bDQ9w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okt6W-00ALdU-P0; Tue, 18 Oct 2022 20:22:24 +0000
Received: from mga03.intel.com ([134.134.136.65])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1okt6U-00ALcw-PT
	for linux-nvme@lists.infradead.org; Tue, 18 Oct 2022 20:22:24 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666124542; x=1697660542;
  h=message-id:date:mime-version:from:subject:to:
   content-transfer-encoding;
  bh=j1LfxFQiKIkahU1oqfPjr+i0bNKAYY7JqFIcWDMtZDg=;
  b=dL2H+zllb9f/cz9uXJhVVofZL9M+CaSP48N9/HPdmzTBwu/AsaHe9okW
   RsYHcQkjiSRmCTOVdsZPhPMzZZXhIPeSw6g+uZwK14ZWhCA/tHrHTGN0e
   SGpFpXOpuw23zLiJ7gdOP+E2oKyedyOgUPWtLBWtyrORyn+SbI1iDU2W6
   gqU2vtRY2G4ung3jhUCqYKGIqrL7tI8iTpxbI9bxs0M2/L+SWhSrh89mK
   JqvApibSIVxTkd0AuM9tmrg6DYjTcMSkHaj7Lq6fT/3cKSrUY1SwvugMe
   b4mM0yzePx80sSzLPqwhflEi5VjNKdtwmbe38hpXx6h+Upsp0+pyitLig
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="307913410"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="307913410"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:22:21 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="579979275"
X-IronPort-AV: E=Sophos;i="5.95,194,1661842800"; 
   d="scan'208";a="579979275"
Received: from fmmunozr-mobl1.amr.corp.intel.com (HELO [10.212.59.160]) ([10.212.59.160])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Oct 2022 13:22:20 -0700
Message-ID: <f3b75aec-d29a-8c6a-1b12-6cf7b83d9892@linux.intel.com>
Date: Tue, 18 Oct 2022 13:22:01 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Content-Language: en-US
From: "Munoz Ruiz, Francisco" <francisco.munoz.ruiz@linux.intel.com>
Subject: [Question] nvme namespace enumerated to 2 when hot-reinserted into a
 server in 5.14 kernel(RHEL 9.1)
To: linux-nvme@lists.infradead.org
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221018_132222_899626_2F849BC7 
X-CRM114-Status: UNSURE (   5.78  )
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


Hi,


We are hardening our tests for RHEL, and we'd like to know if this is 
the expected behavior.

After a couple of tests via trace-cmd and booting with 
nvme_core.multipath=N, we found that the number "2" presented to 
userspace comes from nvme_init_ns_head()->nvme_alloc_ns_head() when an 
SSD is hot-reinserted


ret = ida_simple_get(&ctrl->subsys->ns_ida, 1, 0, GFP_KERNEL);
if (ret < 0)
	goto out_free_head;
head->instance = ret;

Then in nvme_alloc_ns() the string representing a disk name is assembled 
via sprintf because nvme_mpath_set_disk_name returns immediately due to 
multipath == false
/*
  * Without the multipath code enabled, multiple controller per
  * subsystems are visible as devices and thus we cannot use the
  * subsystem instance.
  */
if (!nvme_mpath_set_disk_name(ns, disk->disk_name, &disk->flags))
	sprintf(disk->disk_name, "nvme%dn%d", ctrl->instance,
		ns->head->instance);
ns->disk = disk;


We also observed that the ida API used in core.c was updated in a recent 
commit 8b850475c08caa9545c460d7. Does this fix the namespace numbering 
presented to the user via disk_name? if not, should we pass our tests if 
nvmeXn2 is observed instead of nvmeXn1 when hot-reinserting an SSD?

Thanks,
Francisco.


