Return-Path: <SRS0=/SuC=JR=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAA67C433B4
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:44 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 170996100A
	for <linux-nvme@archiver.kernel.org>; Tue, 20 Apr 2021 14:39:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 170996100A
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=LCVnSbUYPkA8afHolpLP+HL7YPRf2nqdUiozuYW/8Uo=; b=Dozpe4hbqlBLLjaitSoe6JAI6
	VA2Jzc9olqt2GB6Mh1cOt7LZErwH/Ok+MDaJBjfRRGaAJTxqv+tf/0YgwmqeTHwzvXjcIVkiB3se+
	6UXeaqbo1mHo1L0WkrAdUpSlAxutGzRceDgIsf5Ngu3H5QIgXp9qm5eySaV8gnKNqXJXyGWQ3xrzL
	iYe1W8oUkHRqzCBHsnFPyVkpj5SfLsl3pcpncAByJuOhBlfPeREthCur+gdr1CotdHcm8A4zzcmdt
	i6VPD4tz5ScG8Ari3InZXQ9nEuCKjDuvSl8WcVlbp/5cvn8dh3JE6dpMvWhlsFUW5X3jNuqku+sjy
	C55JzmEjQ==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lYrWy-00CMun-Ay; Tue, 20 Apr 2021 14:39:12 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrWw-00CMuf-TX
 for linux-nvme@desiato.infradead.org; Tue, 20 Apr 2021 14:39:10 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=T+yEmtDQxZnRobM2yTHXpbpllEHKIzCjW0+95zQCocs=; b=RAOLOWs+s1HHU8ao6rxuWrw6mz
 YtQU9UGA7cX8lVaVXFQ3dctgMkM0BPGzG0uA7OcpS9Lh41uJcsK/rnguHUVTcmyGuZjsJ6Qc0X920
 +69UFPzSszjOzCYF6QUZhKAOJGox2bgI6BkufaOkzDuePVROJQi6ao42WYIbOU8pB3YkAOPB81enw
 b8gmp5BUV5Lt1QynFsYktHx7AtO6+bY93+UWvT8I5VCpgfCAOY8jeE9WeMlxZ43/fmitGmiFiSqHT
 h9MMewNLRlLBMFssGYkCOSHSJQjV7VyaTjcx4/kPt5nXvjwgWjKQ+wXQ6yFWs0czSoUq4R0mvV/sl
 ABHoK89w==;
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lYrWr-00CCSL-Bg
 for linux-nvme@lists.infradead.org; Tue, 20 Apr 2021 14:39:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1618929542;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 in-reply-to:in-reply-to:references:references;
 bh=T+yEmtDQxZnRobM2yTHXpbpllEHKIzCjW0+95zQCocs=;
 b=hOa1IrSZI/kgG1K26nxhAWj6wDC9IYsRhOTmDqXGmrq1bnsFfBOP1/sK/OzzN/eNd3ec8E
 ARIN34w4r5nmm2+ujO6Ptl5Wx9wKLgyHKy1eaELPR/7jSX/aKvdxssRF7kun1hTgLsQpjR
 8v/CeezPRPHB0xbzeSHoqXKRAJ7Ex/w=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-388-U5yStXyBOxa8G8siGMqhHw-1; Tue, 20 Apr 2021 10:38:59 -0400
X-MC-Unique: U5yStXyBOxa8G8siGMqhHw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E6FF08189C6;
 Tue, 20 Apr 2021 14:38:56 +0000 (UTC)
Received: from localhost (unknown [10.18.25.174])
 by smtp.corp.redhat.com (Postfix) with ESMTPS id 7AD2C60916;
 Tue, 20 Apr 2021 14:38:53 +0000 (UTC)
Date: Tue, 20 Apr 2021 10:38:52 -0400
From: Mike Snitzer <snitzer@redhat.com>
To: Christoph Hellwig <hch@lst.de>
Cc: Jens Axboe <axboe@kernel.dk>, dm-devel@redhat.com,
 linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: Re: [PATCH v3 0/4] nvme: improve error handling and ana_state to
 work well with dm-multipath
Message-ID: <20210420143852.GB14523@redhat.com>
References: <20210416235329.49234-1-snitzer@redhat.com>
 <20210420093720.GA28874@lst.de>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210420093720.GA28874@lst.de>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210420_073905_492501_ED5547EF 
X-CRM114-Status: GOOD (  19.96  )
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

On Tue, Apr 20 2021 at  5:37am -0400,
Christoph Hellwig <hch@lst.de> wrote:

> > RHEL9 is coming, would really prefer that these changes land upstream
> > rather than carry them within RHEL.
> 
> We've told from the very beginning that dm-multipth on nvme is not
> a support configuration.

You have some high quality revisionist history there. But other than
pointing that out I'm not going to dwell on our past discussions on how
NVMe multipathing would be.

> Red Hat decided to ignore that and live with the pain.

Red Hat supports both native nvme-multipath _and_ DM-multipath on NVMe.

The only "pain" I've been living with is trying to get you to be
impartial and allow others to provide Linux multipathing as they see
fit.

> Your major version change is a chance to fix this up on the Red Hat
> side, not to resubmit bogus patches upstream.

Please spare me the vapid and baseless assertion about patches you
refuse to review technically without political motivation.

> In other words: please get your house in order NOW.

My simple 3 patch submission was an attempt to do so. Reality is the
Linux NVMe maintainers need to get their collective house in order.

Until sanity prevails these NVMe changes will be carried in RHEL. And if
you go out of your way to cause trivial, or elaborate, conflicts now
that you _know_ that changes that are being carried it will be handled
without issue.

Sad this is where we are but it is what it is.

Linux is about choice that is founded upon need. Hostile action that
unilaterally limits choice is antithetical to Linux and Open Source.

Mike


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
