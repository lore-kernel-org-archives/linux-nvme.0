Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 511F4C98302
	for <linux-nvme@archiver.kernel.org>; Tue, 22 Sep 2026 15:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=6zQ+hm4QqCKyd5BD+oapjuiiu/DtbKvyK5RPIsPIQqM=; b=IenQ4TRuUQLedDtYjEx9VrIUV9
	xXL5SgEUmFlrrB2UPlfB8H0FyaZ0AqsFdtKRlYf6wyV+aR4lhjwXo7TUaqcu/F6Mc1kPHzipzRBtb
	PmHurEE1KxIQqRzLsXzqS/y9K1ZlcZT/edoOV3uvHM2iONySJu+fuWnpKKBoHeCqZQJgNxG61dCJe
	uUjCFbnDD6NYSfMvyAhCdqmvOOlLM2+wfWq5uuav4Ytgy13g3CZ7Ue9R4URP6HqRglmFScFTELfW/
	cC7SixsRO6gdn/pcHlrpTRV9jL1sOS1vXDZUT/qVDy5JstuOKlUb74uVDPHDLiHX1FHwtS3CTzH9W
	CxfhJbrA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x922U-00000005mLF-2lSp;
	Tue, 22 Sep 2026 15:04:10 +0000
Received: from tor.source.kernel.org ([2600:3c04:e001:324:0:1991:8:25])
	by bombadil.infradead.org with esmtps (Exim 4.99.1 #2 (Red Hat Linux))
	id 1x922T-00000005mKp-43sT
	for linux-nvme@lists.infradead.org;
	Tue, 22 Sep 2026 15:04:10 +0000
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id 68D556020F;
	Tue, 22 Sep 2026 15:04:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EC8C51F00893;
	Tue, 22 Sep 2026 15:04:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790089449;
	bh=6zQ+hm4QqCKyd5BD+oapjuiiu/DtbKvyK5RPIsPIQqM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=AColoS1C+c5ojjM0o46Q/g8EEgI2jyZ5yYbMuI+qJdo65AomwI0xbfnoQ4Uo1/bXv
	 rZ6s5w50Sh93RBppPrI1PW81G0PBHhpiBFVK7NpJdAG/nm7K/ZRM4cYE1SvPSkohmj
	 hzuWFZ/UFRnTLgKfRCOuIUkQiuGjCISDMo5LTiOK8UJza2yR8tcR3LGtnghjf3ilGr
	 speUtTd/ojrLr+EoEe6+wesX/sCG3ZiKNzg47kdGC03gJHQiP+WTmGVbTZNK7LS0yl
	 rsOWxLbZ7yWvnvsbBMTML00RBfdg5NhNbbfXrdMRe769Vbrhni66moA2rnYzJGnyf1
	 FHrKA8XtFYy5A==
Date: Tue, 22 Sep 2026 09:04:07 -0600
From: Keith Busch <kbusch@kernel.org>
To: loberman@redhat.com
Cc: linux-nvme@lists.infradead.org, hch@lst.de, sagi@grimberg.me
Subject: Re: [PATCH v2] nvme-multipath: add iopolicies sysfs attribute
Message-ID: <arKY50Au-OcNdOzl@kbusch-mbp>
References: <20260921144347.49620-1-loberman@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260921144347.49620-1-loberman@redhat.com>
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

On Mon, Sep 21, 2026 at 10:43:47AM -0400, loberman@redhat.com wrote:
> From: Laurence Oberman <loberman@redhat.com>
> 
> The subsystem iopolicy attribute only shows the active policy, so
> there is no way to see which policies are available.
> 
> Changing the output of iopolicy would break existing userspace,
> since nvme-cli compares the value against a bare policy name. Leave
> iopolicy unchanged and add a read-only iopolicies attribute that
> lists the available policies:
> 
>   # cat iopolicies
>   numa round-robin queue-depth
> 
> The current policy is still read from iopolicy.

Thanks, applied to nvme-7.4.

