Return-Path: <SRS0=sXsN=I6=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7710C433B4
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 06:20:54 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1C54461055
	for <linux-nvme@archiver.kernel.org>; Thu,  1 Apr 2021 06:20:54 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1C54461055
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=lst.de
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=13YGKuiIoIvmcUvUGxFmqVZd7esCeo98Tyf6MWFlcwQ=; b=ekHvgL18okssrPt1+5Hh5glYL
	ZGaQ7om4roAd7vFIJol/NI5ODZf5KW9AXQk8kEm0EOqwqrszeDSx3/6DtQDUVaVOpE11KG0P0175o
	eii9Uo4uHzC0Stu0q/fhcvaqhSVfeeWpah0YFcGYkJzPJs2vPwtGrYh5ENQflKr7zz7b9XObjEMIy
	S6f9MTJ4+7TdaPjcRt1oihgQ/0YG2kiTx+GZ7a1HfoCzrl95o+mnCVVKZ6c6ZTkKQjeDrV+O88/Ld
	rPOMZCSHUKXZUq7ExnWiOvqtky26SeaAKD/vNU5yQ2r5OFvOegj0KlcNjW9TPhej3By5fb6mpYhy6
	LecVdRusg==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lRqh6-008f7w-AY; Thu, 01 Apr 2021 06:20:40 +0000
Received: from verein.lst.de ([213.95.11.211])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lRqh2-008f7C-O6
 for linux-nvme@lists.infradead.org; Thu, 01 Apr 2021 06:20:38 +0000
Received: by verein.lst.de (Postfix, from userid 2407)
 id 20EC268B05; Thu,  1 Apr 2021 08:20:32 +0200 (CEST)
Date: Thu, 1 Apr 2021 08:20:31 +0200
From: Christoph Hellwig <hch@lst.de>
To: Sagi Grimberg <sagi@grimberg.me>
Cc: "Ewan D. Milne" <emilne@redhat.com>, Hannes Reinecke <hare@suse.de>,
 Keith Busch <kbusch@kernel.org>, Daniel Wagner <dwagner@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
 Jens Axboe <axboe@fb.com>, Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] nvme-tcp: Check if request has started before
 processing it
Message-ID: <20210401062031.GA25424@lst.de>
References: <20210301175601.116405-1-dwagner@suse.de>
 <6b51a989-5551-e243-abda-5872411ec3ff@grimberg.me>
 <20210311094345.ogm2lxqfuszktuhp@beryllium.lan>
 <70af5b02-10c1-ab0b-1dfc-5906216871b4@grimberg.me>
 <2fc7a320c86f75507584453dd2fbd744de5c170d.camel@redhat.com>
 <ed3ccac0-79ed-fe10-89eb-d403820b4c6a@grimberg.me>
 <20210330232813.GA1935968@dhcp-10-100-145-180.wdc.com>
 <e4bee13c-647a-55ff-2017-27ccfc314973@suse.de>
 <ad2fcbcd6707de4e219b39b012f6e42cb03dc92d.camel@redhat.com>
 <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <5715ef78-eaf1-dcb6-c2a2-f4725e1a01c4@grimberg.me>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210401_072036_959568_FC331EB7 
X-CRM114-Status: GOOD (  16.32  )
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

On Wed, Mar 31, 2021 at 03:24:49PM -0700, Sagi Grimberg wrote:
>
>>> What we can do, though, is checking the 'state' field in the tcp
>>> request, and only allow completions for commands which are in a state
>>> allowing for completions.
>>>
>>> Let's see if I can whip up a patch.
>>
>> That would be great.  BTW in the crash dump I am looking at now, it
>> looks like pdu->command_id was zero in nvme_tcp_recv_data(), and
>> blk_mq_tag_to_rq() returned a request struct that had not been used.
>> So I think we do need to check that the tag was actually allocated.
>
> request tag can't be zero? I forget...

Of course it can.  But the reserved tags are before the normal tags,
so 0 would be a reserved tag for nvme.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
