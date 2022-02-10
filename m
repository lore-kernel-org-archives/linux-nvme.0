Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C2ADC433EF
	for <linux-nvme@archiver.kernel.org>; Thu, 10 Feb 2022 02:52:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ZrIIX0veRLfdDzzaMKY4rTLeJazMI/0466v4AmbCpPI=; b=QPoswe+mbIxhUtlXRN5b3/T5Ra
	keCPHhER9kwmI/2iAsJWWCffLqr+PSyQna/5AHss8tPAbpHkm5xSjEIPyKoPG/ZP5vWDk4mZDQgh5
	c5fJjB23GaPsENSVtF8DRnb/SKN4yvWw7SbU7tZ1khSk9W2dXouKdozuTQeHctnJ4cgvc6i63fKRu
	r0BT+XBDQXWu4Q1Vw51Tv4ImbtDo0xu/Zx+8VtCuEQpzyy63PhbvefHnreLHf4ju5W7EHg+0CPKUe
	eXiYC1GexubPaYGbAFzXB3Uq0d8YCQUPSjh7Yzhkryk1Nb/ACfdhvrYziX/3r/cHmZW06uhUu+syr
	8R+CPs8w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nHzZn-002KFo-4N; Thu, 10 Feb 2022 02:52:55 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nHzZj-002KFK-LJ
 for linux-nvme@lists.infradead.org; Thu, 10 Feb 2022 02:52:53 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1644461569;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=ZrIIX0veRLfdDzzaMKY4rTLeJazMI/0466v4AmbCpPI=;
 b=c2qtpH2cDWqV0TUhfCx7ueD2g2lpOVe73GXUnmZVXJNNtLjsAYxfXwiTyDSNFwxStCurlk
 7YYYlyD9HTbH1mUN/crJUOGQhkigOXMX65SnvjY85BGH8IL9xam7PGlUrIvFfkezzgJsz7
 Es5XjAFxwXyvjvp0atIgtNs2zs0auuw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-453-e8Q6eWFYOwmjm_19GQyPGA-1; Wed, 09 Feb 2022 21:52:47 -0500
X-MC-Unique: e8Q6eWFYOwmjm_19GQyPGA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com
 [10.5.11.22])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 6E4668144E0;
 Thu, 10 Feb 2022 02:52:46 +0000 (UTC)
Received: from [10.22.32.245] (unknown [10.22.32.245])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 835A71002391;
 Thu, 10 Feb 2022 02:52:45 +0000 (UTC)
Message-ID: <56fb153a-ba0e-605b-e774-885c259965a6@redhat.com>
Date: Wed, 9 Feb 2022 21:52:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] nvme-multipath: add an 'ana_groups_only' module option
To: Christoph Hellwig <hch@lst.de>, Hannes Reinecke <hare@suse.de>
Cc: Sagi Grimberg <sagi@grimberg.me>, Keith Busch <keith.busch@wdc.com>,
 linux-nvme@lists.infradead.org
References: <20220207100005.34404-1-hare@suse.de>
 <20220209080747.GA9851@lst.de>
From: John Meneghini <jmeneghi@redhat.com>
Organization: RHEL Core Storge Team
In-Reply-To: <20220209080747.GA9851@lst.de>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=jmeneghi@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220209_185251_830872_6A1088D4 
X-CRM114-Status: GOOD (  23.44  )
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

On 2/9/22 03:07, Christoph Hellwig wrote:
> On Mon, Feb 07, 2022 at 11:00:05AM +0100, Hannes Reinecke wrote:
>> On large installations the ANA log buffer can be exceedingly large;
>> we've come across a controller with 49 ANA Group Descriptors and
>> 65536 namespaces, resulting in an ANA buffer with an order-7 allocation.
>> And this is just to validate that the namespace ID is _really_listed
>> in the log page.
>> So to avoid an overly large memory allocation we can leverage the
>> 'RGO' bit when retrieving the ANA log page, and check whether the
>> ANA group ID from the namespace is found in the ANA descriptors.
>> That cuts down the memory allocation, and provides the same result.
>> But to be on the safe side I've added a module option 'ana_groups_only'
>> to switch between modes.
> 
> How is this supposed to work?  We'll fail to see what namespaces
> the change applies to.
> 
> So in doubt fix the controller config to be less broken (and say hello
> to NetApp and explain them they do not need more namespace for more
> performance), and if that fails switch to a vmalloc allocation for
> the buffer.

I agree with Christoph.  I don't see the point in supporting 65536 namespaces across 49 ana groups or controllers. The problem 
here is: the vendor is trying to turn NVMe into SCSI.

Moreover, I don't understand how implementing this as a MODULE_PARM is supposed to work.  If you configure this module parameter 
on it assumes all NVMe-oF arrays connected to the host support RGO. What's really needed here is some kind of protocol mechanism 
that will allow the host to dynamically discovery if RGO is supported on a controller by controller basis.

And this isn't an NetApp array. Just look at who's asking for this change if you want a clue as to what NVMe-oF array is asking 
for this.  I know for a fact this isn't a NetApp array.

/John


