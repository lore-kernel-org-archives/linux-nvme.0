Return-Path: <SRS0=Lfpf=MM=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01645C07E9B
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 15:10:06 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BC20260FF2
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Jul 2021 15:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BC20260FF2
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:
	Content-Transfer-Encoding:Content-Type:List-Subscribe:List-Help:List-Post:
	List-Archive:List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:
	Message-ID:Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:
	Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
	List-Owner; bh=LsASNwNLyajTZ9p9sMlsFoPFtBIgWnqo8AY8+5O5HtM=; b=j6F0gnv+B+M0cn
	3Oq/3S4vIQzyeRg3z9k2i/cLP8yrtZie5my+LJA21I01SdGyZ4WX39zVvQiD36oM8UDkErG9mhV7G
	7aBdWJJ0vjS3CvTveGKQklH9ycZz9Q9omu32vWXYBF9q8HxILwVmEHK1KetxUxoPL23ylLW2zCUZc
	rIaDflBPH36TjabLwbRyxJdVLhcAfOQaBq/jzZAFicQ53Xpje+pkGhQWDJ35kS16E8Ev15d9Z8g6j
	nYk0TyaLwGJmkGZWS4s2KQStpNOR9dU0tvJTbdrVV6b5wfzcUnn7DDpE2Uh6pGc3ONd4+7jb1TDi6
	v2cgmFP5gTwG5l3VzEBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1m5rNc-00DMLz-Nx; Tue, 20 Jul 2021 15:09:56 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1m5rNa-00DMLM-Cg
 for linux-nvme@lists.infradead.org; Tue, 20 Jul 2021 15:09:55 +0000
Received: by mail.kernel.org (Postfix) with ESMTPSA id 90B7B60FF2;
 Tue, 20 Jul 2021 15:09:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=k20201202; t=1626793794;
 bh=h9T7ypROPhHGrykhC8vOBrXSnKKLlnxnIN9KikGX8Ic=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=i+KbtEyZ2m/ldmSfm5mRvPvuT0ezP7UVKYI9ppEYmgX/CEWpD7IxmNuCSRBJ7VUi0
 jUNv0XnOrycKRT9QNbRXeLNRGODG9jgC/4oetJGUL2YpkGH+qxq9qoN/ntbts6vDir
 78ReVTG9o8zem6SrBjqtp1J5FY/1YBVZMAisss8zAF8KjL7HHdFyLTfxh3sRTAcSfS
 P8RczPE6XOu4KH3x2IUsrxLMcH4+WJa7l2Czm/kHJCMeJsNiGyeHemzYNrJEnwXha4
 tWzNapjaDKZrLo0HjP86bhMrMH6YPm7wg/iHinJTMPanUW7xRrJqeDJvxHzmMbkBIc
 bpr7DxViQbK0Q==
Date: Tue, 20 Jul 2021 08:09:51 -0700
From: Keith Busch <kbusch@kernel.org>
To: Hou Pu <houpu.main@gmail.com>
Cc: hch@lst.de, linux-nvme@lists.infradead.org, sagi@grimberg.me
Subject: Re: [PATCH] nvme: fix nvme_setup_command metadata trace event
Message-ID: <20210720150951.GA2005888@dhcp-10-100-145-180.wdc.com>
References: <20210719164439.2002887-1-kbusch@kernel.org>
 <20210720024847.805-1-houpu.main@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210720024847.805-1-houpu.main@gmail.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210720_080954_502479_29C11745 
X-CRM114-Status: UNSURE (   9.58  )
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
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Tue, Jul 20, 2021 at 10:48:47AM +0800, Hou Pu wrote:
> On Mon, 19 Jul 2021 09:44:39 -0700, Keith Busch wrote:
> > @@ -66,13 +66,13 @@ TRACE_EVENT(nvme_setup_cmd,
> >  		__entry->flags = cmd->common.flags;
> >  		__entry->cid = cmd->common.command_id;
> >  		__entry->nsid = le32_to_cpu(cmd->common.nsid);
> > -		__entry->metadata = le64_to_cpu(cmd->common.metadata);
> > +		__entry->metadata = !!blk_integrity_rq(req);
> >  		__entry->fctype = cmd->fabrics.fctype;
> >  		__assign_disk_name(__entry->disk, req->rq_disk);
> >  		memcpy(__entry->cdw10, &cmd->common.cdw10,
> >  			sizeof(__entry->cdw10));
> >  	    ),
> > -	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%llx, cmd=(%s %s)",
> > +	    TP_printk("nvme%d: %sqid=%d, cmdid=%u, nsid=%u, flags=0x%x, meta=0x%x, cmd=(%s %s)",
> 
> Can we also change "cmd=(%s %s)" to "cmd(%s, %s)" like the target side.

That would have to be a different patch, and you can send it if you
would like to see this change.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
