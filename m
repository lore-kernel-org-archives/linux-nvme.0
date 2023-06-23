Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6E567EB64DA
	for <linux-nvme@archiver.kernel.org>; Fri, 23 Jun 2023 02:45:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=yqsUi3RumJz0LE2tgp22Jk75+usbK1QeE9CEHBqzen8=; b=g1rzPXCj05SvWbnpAhJLi0J5Vi
	mW2qRK+Qsh43OGs8/FGGqHxa9DAK4461Biks5W6dHpVqbmFQ/voknaESiS1YdBF7htAjoUQS8TfIm
	lNKXom10B34fzWoUnNt1/qD6E/K0/gFQ0S3ex0oN3bI+qNZ05otO1cNNieXx/ewoKYRYzWro+0ocJ
	p0rc/WnAgGS5aMviZ+d9gRaQG/CT87z/KvDRGN//u11Lz95hq0MnfjhnC8sHgRPgHP+8szP7pkq2g
	fJKkzsnVCON7/s7Kaj1eITRFeL0ZAbwYSB306tg2XnAmIzroPCXVHV7ghttFfgId8kERsGBPBnB0P
	ayWQjqTw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qCWnZ-002MXY-25;
	Fri, 23 Jun 2023 02:45:21 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qCWnW-002MX0-2y
	for linux-nvme@lists.infradead.org;
	Fri, 23 Jun 2023 02:45:20 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1687488317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=yqsUi3RumJz0LE2tgp22Jk75+usbK1QeE9CEHBqzen8=;
	b=Y2Gl2Kvs0Bl4PFT/v07bN63WT6DG9tMreXK8fgfZ+v2gFhWwO2z0SiHx3IDkTp8Ty/ziyn
	XOOWM6TpaMZgFUzWkd8e+6uqbzf92Xu4kZT+VHkYFvLAD+GlNuSr1kIe/w7/STdWEph22f
	GyJvhklSBcRWhuLq17MOaHhN7BOwiIo=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-567-M5O6GPV_OoCEeYXJJsV9Pw-1; Thu, 22 Jun 2023 22:45:14 -0400
X-MC-Unique: M5O6GPV_OoCEeYXJJsV9Pw-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
	(using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 168D6185A78B;
	Fri, 23 Jun 2023 02:45:14 +0000 (UTC)
Received: from [10.22.18.42] (unknown [10.22.18.42])
	by smtp.corp.redhat.com (Postfix) with ESMTP id EF7B81121330;
	Fri, 23 Jun 2023 02:45:12 +0000 (UTC)
Message-ID: <6fc25ae7-163b-518b-e674-87fc469f339a@redhat.com>
Date: Thu, 22 Jun 2023 22:45:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: What's the upstream disposition with nvme-stas?
To: "smith, erik" <Erik.Smith@dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>,
 Keith Busch <kbusch@kernel.org>
Cc: "Rose, Charles" <Charles.Rose@dell.com>,
 "Belanger, Martin" <Martin.Belanger@dell.com>, Hannes Reinecke
 <hare@suse.de>, Martin Wilck <mwilck@suse.com>,
 Daniel Wagner <dwagner@suse.de>
References: <b7f6bba3-30b0-8d55-e285-b922101a04f4@redhat.com>
 <BLAPR19MB42286C3AB16C09DF205ED062E422A@BLAPR19MB4228.namprd19.prod.outlook.com>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <BLAPR19MB42286C3AB16C09DF205ED062E422A@BLAPR19MB4228.namprd19.prod.outlook.com>
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.3
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230622_194519_056871_740F5FC8 
X-CRM114-Status: GOOD (  12.23  )
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

Thanks for your reply Erik.

On 6/22/23 16:13, smith, erik wrote:
> John, first and foremost, the conversation between Dell and Red Hat the other day was under NDA. 

I don't think I have said anything here that betrays any NDA. It is publicly known that Dell has authored both TP-8009/8010 and 
nvme-stas... and that Dell is asking the upstream linux community and the linux distribution companies to accept and support 
nvme-stas.

> Because of this, I will not debate what you said on a point by point basis, but it's fair to state we remember things differently.

Which is exactly why I want to have a public conversation where people can be held accountable for what they say and/or 
remember.  I am not looking for a debate, I am looking for clarity about who said what.

> What I can say publicly is this... We asked you to start a thread with Hannes and Keith because, despite being "tired of the hear-say game that happens with private conversations.", you were attributing all kinds of statements to them that did not align with what we had heard.

So you thought that meant I was going to start another three way private conversation between Keith, Hannes, Dell and Red Hat?

I am speaking for myself here... and I am doing so publicly so Hannes, Keith or anybody else can correct me if I have 
misrepresented them or attributed anything to them or anybody else wrongly.

/John


