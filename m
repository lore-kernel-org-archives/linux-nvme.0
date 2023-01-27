Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id ED3A1C38142
	for <linux-nvme@archiver.kernel.org>; Fri, 27 Jan 2023 15:58:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:Content-Type:
	MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
	Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=tLOzDjvHRmaHEz/I6ZmXP+vg+lY821lNT4n7yHy3U2s=; b=lFby1D9XA7aaKAM+1oS3HVljVA
	OrV2FoEc0zdSAoNWasVaW/U5Y0SDVxSKjKpeOdUkHmf5a68yZmquppGoSIby+QJsvG81xciXn67DJ
	DPa3rJvhrNgcNMs1vUfzAI6GI75ILZD4S3FV0EuS+DCptimeCPbieLUVBW5cUnHlUKuqX5g/YzN/m
	SKW4Axe6N0kRWX7oUYL5gkMa6mj+fU6+xy7nHxVTYYjFJWDIsvk+3HtB44JNVIpwXHY1wT5YYPBWP
	01eT+Nm0uxDGK2arC5TO7HZZA+bSvlJ5ucx1MekXlPGN9QUWFOFrmS6iOBhUzYVX82VdM9iLEab4C
	8seuBtQg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLR7l-00FYY6-4Z; Fri, 27 Jan 2023 15:58:45 +0000
Received: from dfw.source.kernel.org ([2604:1380:4641:c500::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pLR7d-00FYUe-2G
	for linux-nvme@lists.infradead.org; Fri, 27 Jan 2023 15:58:38 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.source.kernel.org (Postfix) with ESMTPS id A0B7E61A5E;
	Fri, 27 Jan 2023 15:58:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F332C433D2;
	Fri, 27 Jan 2023 15:58:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1674835114;
	bh=2iyuN3q86Fbm+EXwvl8UWOEpO4DMmEpqlNMDNmHMa3g=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=tbGVl8GaxMoCVgSyZHmQCbcTznwZEqgMfA1fhZl5pZ+0uE4LhPDaxBzqDFr3p+FFo
	 KFEMVgKf0VXZ/WBqx6eFhM1RJmDuawvWsgC93k+lGxnF5DFuoDazko3n3XtSxtHiyc
	 ip0k2fwDzR85gJSYnoG43bCKwsMJSFosn6xzCHl2esb5dgEvG60A82G5ifAegpCNU6
	 c578nQTuyME0t9nV4NUDX/ClraUUyO1WgRLe2LMO+1L3ZlqIAhJezjJ1jsvdt+oX+c
	 I2cBXdeIsr7PZio5csTwKLP89lEpv5ioGbGCGLGWuYrl7YVfKPNQA0JYOJ87QBQLpv
	 QMaw4P23EmddA==
Date: Fri, 27 Jan 2023 08:58:31 -0700
From: Keith Busch <kbusch@kernel.org>
To: Maurizio Lombardi <mlombard@redhat.com>
Cc: axboe@fb.com, hch@lst.de, sagi@grimberg.me,
	linux-nvme@lists.infradead.org
Subject: Re: [PATCH] nvme: fix potential invalid pointer dereference
Message-ID: <Y9P0p60kLZUc/kua@kbusch-mbp.dhcp.thefacebook.com>
References: <20230127154237.349113-1-mlombard@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127154237.349113-1-mlombard@redhat.com>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230127_075837_169517_F959C088 
X-CRM114-Status: GOOD (  12.40  )
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

On Fri, Jan 27, 2023 at 04:42:37PM +0100, Maurizio Lombardi wrote:
> If nvme_alloc_admin_tag_set() fails, the admin_q and fabrics_q pointers
> are left with an invalid, non-NULL value;
> Other functions may then check the pointers' value and dereference them,
> like it happens in
> nvme_probe() -> out_disable: -> nvme_dev_remove_admin().
> 
> Fix the bug by setting admin_q and fabrics_q to NULL in case of error.
> Also fix a NULL pointer dereference (the ctrl->admin_tagset pointer
> is only initialized just before returning success;
> therefore, in the error code path, blk_mq_free_tag_set() must be
> called against the "set" variable).

Looks good.

Reviewed-by: Keith Busch <kbusch@kernel.org>

