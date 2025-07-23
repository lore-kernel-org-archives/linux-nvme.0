Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F09FC83F1A
	for <linux-nvme@archiver.kernel.org>; Wed, 23 Jul 2025 16:58:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=RRn9FpaKArn0FG0DYWvSxtBFbiaxMzHiCufTL2+OF1o=; b=kWX4tpsc7BpUrJktkxaV/LXFn+
	p196+3+y1hCmqpFEzjM3NOp/vVlVnIWqAZgn9EF3NSmX8sKhjHjpUOFfB7P6CvwgSHMLOlBPjgZ5j
	0p4fYjQsyGYBQKZgtcSfEQcYO+KgHbbf3tW+0m26MMs+xHGhIIiVVhx8LjmeJyns5LftAKV1tg1zp
	uce/9hQgwxEBwAEO4a6Pkz+XKQeOum8tDPf/YRVh7QuhTUQPa5oPq7AB3uvkWWA5utx7jyb+f6jGS
	eYuzc5lSETKIBkqJun8b5E4icV+oBAbx1iuDdLnWdMPcC1aSLz/wzCvxoKtqUQkCFFDg2fteBdZcg
	wYu3uOnA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uecns-00000005Xyo-42zq;
	Wed, 23 Jul 2025 16:58:52 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1uecno-00000005XyJ-3Av5
	for linux-nvme@lists.infradead.org;
	Wed, 23 Jul 2025 16:58:52 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1753289926;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RRn9FpaKArn0FG0DYWvSxtBFbiaxMzHiCufTL2+OF1o=;
	b=E8eVXqdUGsDoDyOI0p+PmNBILs0w4dJuUZ7CADPTHrEL58PMRiuUfdtT78kxxms05vzvTG
	X4LBNanctFoiA2F9ZehIJFbUd/cGDtopGrOjiIy21c7A46DKu1xDstTBY5TaLInXt8dZeq
	+9CxasKjm3sghCJCjAK9Zvram25iCWs=
Received: from mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com
 (ec2-54-186-198-63.us-west-2.compute.amazonaws.com [54.186.198.63]) by
 relay.mimecast.com with ESMTP with STARTTLS (version=TLSv1.3,
 cipher=TLS_AES_256_GCM_SHA384) id us-mta-654-pkTI_R-CPBCIZr2BCgRBpg-1; Wed,
 23 Jul 2025 12:58:42 -0400
X-MC-Unique: pkTI_R-CPBCIZr2BCgRBpg-1
X-Mimecast-MFC-AGG-ID: pkTI_R-CPBCIZr2BCgRBpg_1753289921
Received: from mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com [10.30.177.111])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by mx-prod-mc-02.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTPS id 2FA221956087;
	Wed, 23 Jul 2025 16:58:35 +0000 (UTC)
Received: from [10.17.17.193] (unknown [10.17.17.193])
	by mx-prod-int-08.mail-002.prod.us-west-2.aws.redhat.com (Postfix) with ESMTP id EBBE0180035E;
	Wed, 23 Jul 2025 16:58:30 +0000 (UTC)
Message-ID: <552ad157-ae0d-4e12-9cd4-56dc06da3457@redhat.com>
Date: Wed, 23 Jul 2025 12:58:30 -0400
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v8 7/8] nvme: sysfs: emit the marginal path state in
 show_state()
To: Hannes Reinecke <hare@suse.de>, Keith Busch <kbusch@kernel.org>
Cc: Bryan Gurney <bgurney@redhat.com>, linux-nvme@lists.infradead.org,
 hch@lst.de, sagi@grimberg.me, axboe@kernel.dk, james.smart@broadcom.com,
 dick.kennedy@broadcom.com, njavali@marvell.com, linux-scsi@vger.kernel.org
References: <20250709211919.49100-1-bgurney@redhat.com>
 <20250709211919.49100-8-bgurney@redhat.com> <aG7pSA6TOAANYrru@kbusch-mbp>
 <35738598-0733-408c-8597-20c3599a8973@redhat.com>
 <aHa0JpsASqGuHdOA@kbusch-mbp> <ccb69ee6-bd5e-4585-9ccc-0c49cb30f1a9@suse.de>
 <aH7-F2WxrhoCiK7O@kbusch-mbp> <4c97cc61-bb9f-4121-8681-22c9e548fe0a@suse.de>
Content-Language: en-US
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <4c97cc61-bb9f-4121-8681-22c9e548fe0a@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 3.4.1 on 10.30.177.111
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20250723_095848_869850_BBACADD2 
X-CRM114-Status: GOOD (  11.79  )
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


On 7/22/25 2:41 AM, Hannes Reinecke wrote:
> On 7/22/25 04:57, Keith Busch wrote:
>> On Wed, Jul 16, 2025 at 08:07:51AM +0200, Hannes Reinecke wrote:
>>
>> Okay, but can we call it "degraded" instead of "marginal"? The latter
>> implies the poor quality is endemic to that path rather than a temporary
>> condition.
> 
> Sure we can.
> (Although technically it _is_ endemic as it won't change without
> user interaction. But I digress :-)
> \

OK. We'll change this from "marginal" to "degraded" and I'll have Bryan send a v9 patch series.

Is there anything else we want to change with this series before we do that?

/John


