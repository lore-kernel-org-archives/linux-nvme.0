Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4021FCA16D
	for <linux-nvme@archiver.kernel.org>; Mon,  9 Mar 2026 18:04:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:References:Message-ID:Subject:Cc:To:
	From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Qqyp7H5JqTdq72rTloWLs2u0RHxjFFUjNAszu/wqacU=; b=RmE3KEPF2zIUp6KYcrUMds60f8
	MbTzi1uO7TN+dlSLFatYYxQT2Sd2BB0ZlUDzGCDgUl11La63r+eZMH6BANKqVCGikC0phKAfq1nPo
	XnYkXaItge8XJyz75BuzL4A18DBczDRJNgSAQapedwYYlUF+Mbu5iGAIzV1MGHwzKx6OYY5a1Hgt9
	PZ2Y7jeCS14CMCtZ2QY6hxrp+sWVPpuUtXxCCCDhOwuANo7Ezg6vjFxQ8JCsF1BkbJaJ6JIxgalwf
	x9Mk3tvQ9E3zmTVpmtafavAoGcTIzckK7EMSBWFFEtLzFXAtqCKKcI3KIiewIJvUxMuSMHCuuPqbz
	ePmVQoeg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzey5-00000007s8q-2xfL;
	Mon, 09 Mar 2026 18:04:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzey2-00000007s88-2twO
	for linux-nvme@lists.infradead.org;
	Mon, 09 Mar 2026 18:04:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1773079471;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Qqyp7H5JqTdq72rTloWLs2u0RHxjFFUjNAszu/wqacU=;
	b=TBq2JS5aG3mFTx/3vZLi4p6s+dn+oMqBsgjJc85K/JHBkQxvyX9O2WCPKyoM8DTMbyZaEk
	k92Nbj+rAbLE48h38bpMLTmG5v1ShX0jPp0Puod1l7zk+5SsaAxAHrWDQaYuaH8Ancqxp/
	2VycWderibJvcwyBYFJJqWYYdc/ucHM=
Received: from mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-35-165-154-97.us-west-2.compute.amazonaws.com [35.165.154.97]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-450-myLx3K4OPQeaPpmENVtp6g-1; Mon,
 09 Mar 2026 14:04:25 -0400
X-MC-Unique: myLx3K4OPQeaPpmENVtp6g-1
X-Mimecast-MFC-AGG-ID: myLx3K4OPQeaPpmENVtp6g_1773079464
Received: from mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.93])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 15187180049D;
	Mon,  9 Mar 2026 18:04:23 +0000 (UTC)
Received: from my-developer-toolbox-latest (unknown [10.2.16.255])
	by mx-prod-int-06.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id 75057180075D;
	Mon,  9 Mar 2026 18:04:20 +0000 (UTC)
Date: Mon, 9 Mar 2026 11:04:19 -0700
From: Chris Leech <cleech@redhat.com>
To: yunje shin <yjshin0438@gmail.com>
Cc: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>, 
	Chaitanya Kulkarni <kch@nvidia.com>, Sagi Grimberg <sagi@grimberg.me>, Christoph Hellwig <hch@lst.de>, 
	linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org, ioerts@kookmin.ac.kr
Subject: Re: [PATCH] nvmet: auth: validate dhchap id list lengths(KASAN:
 slab-out-of-bounds)
Message-ID: <20260309-scalding-propeller-e00bf0af6519@redhat.com>
References: <20260211065925.2878336-1-ioerts@kookmin.ac.kr>
 <CAMX6_QEQ0MZTPv3+ma6cESW6sXrzHSNttoRTY5wNf9p98caa8A@mail.gmail.com>
 <CAMX6_QGn=0riCV+DZewc98b+AAdemj8ani9bQg-T+epFC5kAhw@mail.gmail.com>
 <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com>
MIME-Version: 1.0
In-Reply-To: <CAMX6_QH7xiTxLbF4pZHVs9Umw=j70c-dmb3t97c6XBEEEg-kpA@mail.gmail.com>
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.93
X-Mimecast-MFC-PROC-ID: 5WlqkErDaHpNJByAT2Kc1wR1wWeoApL3mA2H-R-8HBw_1773079464
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260309_110434_807832_6EC29B6D 
X-CRM114-Status: GOOD (  38.99  )
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

While validating halen and dhlen is a good idea, I don't understand the
reasoning behind the idlist_half calculations. idlist is a fixed sized 
60 byte array, and the DH IDs alway start 30 bytes in.

How did you trigger the KASAN issue?  Are you injecting an invalid
dhlen?  What is the host side, as the linux host driver has a hard coded
halen of 3 and dhlen of 6.

- Chris

On Mon, Mar 09, 2026 at 12:09:01AM +0900, yunje shin wrote:
> Just following up on this patch in case it got buried.
> The KASAN slab-out-of-bounds read is still reproducible on my side.
> I'd appreciate any feedback.
> 
> Thanks,
> Yunje Shin
> 
> On Wed, Feb 18, 2026 at 1:04 PM yunje shin <yjshin0438@gmail.com> wrote:
> >
> > I've confirmed that the issue is still present and the KASAN
> > slab-out-of-bounds read is still reproducible. Please let me know if
> > there are any concerns or if a v2 is needed.
> >
> > Thanks, Yunje Shin
> >
> > On Thu, Feb 12, 2026 at 10:49 AM yunje shin <yjshin0438@gmail.com> wrote:
> > >
> > > The function nvmet_auth_negotiate() parses the idlist array in the
> > > struct nvmf_auth_dhchap_protocol_descriptor payload. This array is 60
> > > bytes and is logically divided into two 30-byte halves: the first half
> > > for HMAC IDs and the second half for DH group IDs. The current code
> > > uses a hardcoded +30 offset for the DH list, but does not validate
> > > halen and dhlen against the per-half bounds. As a result, if a
> > > malicious host sends halen or dhlen larger than 30, the loops can read
> > > beyond the intended half of idlist, and for sufficiently large values
> > > read past the 60-byte array into adjacent slab memory, triggering the
> > > observed KASAN slab-out-of-bounds read.
> > >
> > > This patch fixes the issue by:
> > >     - Computing the half-size from sizeof(idlist) (idlist_half)
> > > instead of hardcoding 30
> > >     - Validating both halen and dhlen are within idlist_half
> > >     - Replacing the hardcoded DH offset with idlist_half
> > >
> > > Thanks,
> > > Yunje Shin
> > >
> > > On Wed, Feb 11, 2026 at 3:59 PM YunJe Shin <yjshin0438@gmail.com> wrote:
> > > >
> > > > Validate DH-HMAC-CHAP hash/DH list lengths before indexing the idlist halves to prevent out-of-bounds reads.
> > > >
> > > > KASAN report:
> > > > [   37.160829] Call Trace:
> > > > [   37.160831]  <TASK>
> > > > [   37.160832]  dump_stack_lvl+0x5f/0x80
> > > > [   37.160837]  print_report+0xd1/0x640
> > > > [   37.160842]  ? __pfx__raw_spin_lock_irqsave+0x10/0x10
> > > > [   37.160846]  ? kfree+0x137/0x390
> > > > [   37.160850]  ? kasan_complete_mode_report_info+0x2a/0x200
> > > > [   37.160854]  kasan_report+0xe5/0x120
> > > > [   37.160856]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > > [   37.160860]  ? nvmet_execute_auth_send+0x19a9/0x1f00
> > > > [   37.160863]  __asan_report_load1_noabort+0x18/0x20
> > > > [   37.160866]  nvmet_execute_auth_send+0x19a9/0x1f00
> > > > [   37.160870]  nvmet_tcp_io_work+0x17a8/0x2720
> > > > [   37.160874]  ? __pfx_nvmet_tcp_io_work+0x10/0x10
> > > > [   37.160877]  process_one_work+0x5e9/0x1020
> > > > [   37.160881]  ? __kasan_check_write+0x18/0x20
> > > > [   37.160885]  worker_thread+0x446/0xc80
> > > > [   37.160889]  ? __pfx_worker_thread+0x10/0x10
> > > > [   37.160891]  kthread+0x2d7/0x3c0
> > > > [   37.160894]  ? __pfx_kthread+0x10/0x10
> > > > [   37.160897]  ret_from_fork+0x39f/0x5d0
> > > > [   37.160900]  ? __pfx_ret_from_fork+0x10/0x10
> > > > [   37.160903]  ? __kasan_check_read+0x15/0x20
> > > > [   37.160906]  ? __switch_to+0xb45/0xf90
> > > > [   37.160910]  ? __switch_to_asm+0x39/0x70
> > > > [   37.160914]  ? __pfx_kthread+0x10/0x10
> > > > [   37.160916]  ret_from_fork_asm+0x1a/0x30
> > > > [   37.160920]  </TASK>
> > > > [   37.160921]
> > > > [   37.174141] Allocated by task 11:
> > > > [   37.174377]  kasan_save_stack+0x3d/0x60
> > > > [   37.174697]  kasan_save_track+0x18/0x40
> > > > [   37.175043]  kasan_save_alloc_info+0x3b/0x50
> > > > [   37.175420]  __kasan_kmalloc+0x9c/0xa0
> > > > [   37.175762]  __kmalloc_noprof+0x197/0x480
> > > > [   37.176117]  nvmet_execute_auth_send+0x39e/0x1f00
> > > > [   37.176529]  nvmet_tcp_io_work+0x17a8/0x2720
> > > > [   37.176912]  process_one_work+0x5e9/0x1020
> > > > [   37.177275]  worker_thread+0x446/0xc80
> > > > [   37.177616]  kthread+0x2d7/0x3c0
> > > > [   37.177906]  ret_from_fork+0x39f/0x5d0
> > > > [   37.178238]  ret_from_fork_asm+0x1a/0x30
> > > > [   37.178591]
> > > > [   37.178735] The buggy address belongs to the object at ffff88800aecc800
> > > > [   37.178735]  which belongs to the cache kmalloc-96 of size 96
> > > > [   37.179790] The buggy address is located 0 bytes to the right of
> > > > [   37.179790]  allocated 72-byte region [ffff88800aecc800, ffff88800aecc848)
> > > > [   37.180931]
> > > > [   37.181079] The buggy address belongs to the physical page:
> > > > [   37.181572] page: refcount:0 mapcount:0 mapping:0000000000000000 index:0x0 pfn:0xaecc
> > > > [   37.182393] flags: 0x100000000000000(node=0|zone=1)
> > > > [   37.182819] page_type: f5(slab)
> > > > [   37.183080] raw: 0100000000000000 ffff888006c41280 dead000000000122 0000000000000000
> > > > [   37.183730] raw: 0000000000000000 0000000000200020 00000000f5000000 0000000000000000
> > > > [   37.184333] page dumped because: kasan: bad access detected
> > > > [   37.184783]
> > > > [   37.184918] Memory state around the buggy address:
> > > > [   37.185315]  ffff88800aecc700: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > > [   37.185835]  ffff88800aecc780: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > > [   37.186336] >ffff88800aecc800: 00 00 00 00 00 00 00 00 00 fc fc fc fc fc fc fc
> > > > [   37.186839]                                               ^
> > > > [   37.187255]  ffff88800aecc880: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > > [   37.187763]  ffff88800aecc900: fa fb fb fb fb fb fb fb fb fb fb fb fc fc fc fc
> > > > [   37.188261] ==================================================================
> > > > [   37.188938] ==================================================================
> > > >
> > > > Fixes: db1312dd95488 ("nvmet: implement basic In-Band Authentication")
> > > > Signed-off-by: YunJe Shin <ioerts@kookmin.ac.kr>
> > > > ---
> > > >  drivers/nvme/target/fabrics-cmd-auth.c | 13 ++++++++++++-
> > > >  1 file changed, 12 insertions(+), 1 deletion(-)
> > > >
> > > > diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
> > > > index 5946681cb0e3..8ad3255aec4a 100644
> > > > --- a/drivers/nvme/target/fabrics-cmd-auth.c
> > > > +++ b/drivers/nvme/target/fabrics-cmd-auth.c
> > > > @@ -36,6 +36,7 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
> > > >         struct nvmet_ctrl *ctrl = req->sq->ctrl;
> > > >         struct nvmf_auth_dhchap_negotiate_data *data = d;
> > > >         int i, hash_id = 0, fallback_hash_id = 0, dhgid, fallback_dhgid;
> > > > +       size_t idlist_half;
> > > >
> > > >         pr_debug("%s: ctrl %d qid %d: data sc_d %d napd %d authid %d halen %d dhlen %d\n",
> > > >                  __func__, ctrl->cntlid, req->sq->qid,
> > > > @@ -72,6 +73,15 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
> > > >             NVME_AUTH_DHCHAP_AUTH_ID)
> > > >                 return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> > > >
> > > > +       /*
> > > > +        * idlist[0..idlist_half-1]: hash IDs
> > > > +        * idlist[idlist_half..]: DH group IDs
> > > > +        */
> > > > +       idlist_half = sizeof(data->auth_protocol[0].dhchap.idlist) / 2;
> > > > +       if (data->auth_protocol[0].dhchap.halen > idlist_half ||
> > > > +           data->auth_protocol[0].dhchap.dhlen > idlist_half)
> > > > +               return NVME_AUTH_DHCHAP_FAILURE_INCORRECT_PAYLOAD;
> > > > +
> > > >         for (i = 0; i < data->auth_protocol[0].dhchap.halen; i++) {
> > > >                 u8 host_hmac_id = data->auth_protocol[0].dhchap.idlist[i];
> > > >
> > > > @@ -98,7 +108,8 @@ static u8 nvmet_auth_negotiate(struct nvmet_req *req, void *d)
> > > >         dhgid = -1;
> > > >         fallback_dhgid = -1;
> > > >         for (i = 0; i < data->auth_protocol[0].dhchap.dhlen; i++) {
> > > > -               int tmp_dhgid = data->auth_protocol[0].dhchap.idlist[i + 30];
> > > > +               int tmp_dhgid =
> > > > +                       data->auth_protocol[0].dhchap.idlist[i + idlist_half];
> > > >
> > > >                 if (tmp_dhgid != ctrl->dh_gid) {
> > > >                         dhgid = tmp_dhgid;
> > > > --
> > > > 2.43.0
> > > >
> 


