Return-Path: <SRS0=ggB5=DC=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 506E2C4363D
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:14:03 +0000 (UTC)
Received: from merlin.infradead.org (merlin.infradead.org [205.233.59.134])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id CD64620878
	for <linux-nvme@archiver.kernel.org>; Fri, 25 Sep 2020 15:14:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="29wUBgc+";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=kernel.org header.i=@kernel.org header.b="PYP9Lvc+"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org CD64620878
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=kernel.org
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=merlin.20170209; h=Sender:Content-Transfer-Encoding:
	Content-Type:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:MIME-Version:References:In-Reply-To:Date:To:From:
	Subject:Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=U4sOhDAB3ULhvG/mlIarkjf628vYxEOJpWXs5wlQWHI=; b=29wUBgc+N0YTmVmVymu6dB3Eu
	xXAZ46ATOCr+lnRrORetZVzCrxZU8oTWj1RW37A2T3K6tCuV1WyoGSulF+Za60/uQgjMauPemM1Af
	ld1eoXYIDzP31jNixioibZCyTOu5mEn7M5tM2xkgUt8JEv4WbOZZHmi7XiB7lqz+ZQRCqt/OVuYcW
	vtzyapeth2HnQ3QfrPUuKq/XrbaYbwC5NwmpJPuOG3cUgDdvwuHBVIItN07I0dkB1JvdoH5VvC5//
	Vs2DArbYmW/4X4x3XI5T1d6/rppqlgdbN1ptNjzZU4XLHmPtBKvgFhFWy3gOek9F2tC2L1+b7H6I2
	3DSeeJ7HA==;
Received: from localhost ([::1] helo=merlin.infradead.org)
	by merlin.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1kLpQ7-0004xj-Qa; Fri, 25 Sep 2020 15:13:59 +0000
Received: from mail.kernel.org ([198.145.29.99])
 by merlin.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1kLpQ4-0004vy-VT
 for linux-nvme@lists.infradead.org; Fri, 25 Sep 2020 15:13:57 +0000
Received: from tleilax.poochiereds.net
 (68-20-15-154.lightspeed.rlghnc.sbcglobal.net [68.20.15.154])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by mail.kernel.org (Postfix) with ESMTPSA id AACF0208B6;
 Fri, 25 Sep 2020 15:13:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
 s=default; t=1601046835;
 bh=8haPYMN6i4R8L0rBRDB+RFTRiwwmhl0O2ZTgf2GjGgs=;
 h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
 b=PYP9Lvc+6VpK6zDfYTXAvOODiQyNe45LDl14372p88r2vjqI0Q0pVVj/uOIhNLXRe
 MOObG21yv2R16u9QGAyn4b7MMY1qecLWzvLxq+120CigHpgpMO4nijXRMB7Y0yoTFo
 Ras3xD5JtcMdTtzOri8qm/zU75p/qRv0mJJwUPAk=
Message-ID: <955efe40d1df7ba78cd0e0f27ba13ae7650ea927.camel@kernel.org>
Subject: Re: [PATCH v8 7/7] libceph: use sendpage_ok() in ceph_tcp_sendpage()
From: Jeff Layton <jlayton@kernel.org>
To: Coly Li <colyli@suse.de>, linux-block@vger.kernel.org, 
 linux-nvme@lists.infradead.org, netdev@vger.kernel.org, 
 open-iscsi@googlegroups.com, linux-scsi@vger.kernel.org, 
 ceph-devel@vger.kernel.org
Date: Fri, 25 Sep 2020 11:13:53 -0400
In-Reply-To: <20200925150119.112016-8-colyli@suse.de>
References: <20200925150119.112016-1-colyli@suse.de>
 <20200925150119.112016-8-colyli@suse.de>
User-Agent: Evolution 3.36.5 (3.36.5-1.fc32) 
MIME-Version: 1.0
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200925_111357_074750_65718BEF 
X-CRM114-Status: GOOD (  18.60  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Ilya Dryomov <idryomov@gmail.com>, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On Fri, 2020-09-25 at 23:01 +0800, Coly Li wrote:
> In libceph, ceph_tcp_sendpage() does the following checks before handle
> the page by network layer's zero copy sendpage method,
> 	if (page_count(page) >= 1 && !PageSlab(page))
> 
> This check is exactly what sendpage_ok() does. This patch replace the
> open coded checks by sendpage_ok() as a code cleanup.
> 
> Signed-off-by: Coly Li <colyli@suse.de>
> Cc: Ilya Dryomov <idryomov@gmail.com>
> Cc: Jeff Layton <jlayton@kernel.org>
> ---
>  net/ceph/messenger.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/net/ceph/messenger.c b/net/ceph/messenger.c
> index bdfd66ba3843..d4d7a0e52491 100644
> --- a/net/ceph/messenger.c
> +++ b/net/ceph/messenger.c
> @@ -575,7 +575,7 @@ static int ceph_tcp_sendpage(struct socket *sock, struct page *page,
>  	 * coalescing neighboring slab objects into a single frag which
>  	 * triggers one of hardened usercopy checks.
>  	 */
> -	if (page_count(page) >= 1 && !PageSlab(page))
> +	if (sendpage_ok(page))
>  		sendpage = sock->ops->sendpage;
>  	else
>  		sendpage = sock_no_sendpage;

Looks like a reasonable change to make. Assuming that there is no
objection to the new helper:

Acked-by: Jeff Layton <jlayton@kernel.org>


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
