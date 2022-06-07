Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 000F7C433EF
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Jun 2022 16:12:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:In-Reply-To:
	Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=MuC/fQh8YbdpYdn2BP3N1r69QeBod8qmVExLueVXhms=; b=y3/T/jjyHzVvCJX5NPGpii2tgH
	Qcyls2EuylRkGRbtMvQBHf/8zfunQTRX51eNxPzlnZGHZ0eEglEi17VkUKDkP2IPJin0jyUJFBQp6
	ZnPxlMNCBUuqVdOc40OaoAZ8CQJ5O0AtqBYql+qpUIVpib2xHWiqWHEyYwn4K8FZPnQijJQS2AvL0
	aNe0v3jUDbpfXI09xHY4uuiMTbIhVE/Le4opqDSDBWjhIzc6jWnRuVp0m2M4rc0h6ieYJv20qo10U
	VoZhpLFgKcvlu8gwfU6H8fJuizBR1SvdEgb8UEb5S6+oQvl7hUH3cAuwsTGSRHReGEFXBH2RdoIWw
	ZB47dcag==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyboK-008OjS-NX; Tue, 07 Jun 2022 16:12:04 +0000
Received: from ams.source.kernel.org ([2604:1380:4601:e00::1])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nyboI-008OhU-Gw
	for linux-nvme@lists.infradead.org; Tue, 07 Jun 2022 16:12:03 +0000
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ams.source.kernel.org (Postfix) with ESMTPS id 05B8DB82189;
	Tue,  7 Jun 2022 16:11:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CC74C34114;
	Tue,  7 Jun 2022 16:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1654618316;
	bh=xnZyLh9MglV87sUUDApLik+cZvW272wQ3/jfI2c35fs=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=BLBTWbogFDKfUCKZhFSv1kCiTqK7tJkvsL1Ac/1ZnVmWUl9L46R//RhIlXghOIQjY
	 /xkGFzjIAF8IRjsM/R4lOIXA5IcRAEXnYFMg+Im6OdfZbt7EuPTAH6DZ2JsMC1vt98
	 GFG9CM6yLgnIUHq2bQhJji2N7+NWe9O1GrCZ3xSpwdk5p8jd2zIbUf4Kd/JPBputXr
	 g8aS3SdrtNVKoaUJ638U3Xj8RZV12dLB7YgWGp06B7s8rzhyk4fcE3oCCnzmX03WKE
	 HBHtoXFL/Y2cZJUxhgH2ygWcvZL6KdBwn7vQ/T9ocyIk3L067o6NZAwGPtNzLKy0GC
	 qhtNt+MLiJayw==
Date: Tue, 7 Jun 2022 10:11:53 -0600
From: Keith Busch <kbusch@kernel.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <linux@weissschuh.net>
Cc: Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>,
	Sagi Grimberg <sagi@grimberg.me>, linux-nvme@lists.infradead.org,
	linux-kernel@vger.kernel.org
Subject: Re: [PATCH] nvme: add device name to warning in uuid_show()
Message-ID: <Yp94yTFrrkbBYqsj@kbusch-mbp.dhcp.thefacebook.com>
References: <20220607155555.8623-1-linux@weissschuh.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220607155555.8623-1-linux@weissschuh.net>
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220607_091202_748232_69B2F289 
X-CRM114-Status: GOOD (  11.26  )
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

On Tue, Jun 07, 2022 at 05:55:55PM +0200, Thomas Weißschuh wrote:
>  	if (uuid_is_null(&ids->uuid)) {
> -		printk_ratelimited(KERN_WARNING
> -				   "No UUID available providing old NGUID\n");
> +		dev_warn_ratelimited(dev, "No UUID available providing old NGUID\n");
>  		return sysfs_emit(buf, "%pU\n", ids->nguid);

The line split was correct to prevent this overly long line. But otherwise,
this looks good, though I'm wondering why this needs to be printed every time
someone reads the attribute.

