Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D191C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 14:57:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 1FB6A2065F
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 14:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="DncKh4Cy";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zk9rUi9D"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 1FB6A2065F
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=FFpYytVpuBRiCQTUBWG+4jCsf4MzJZ3dq+1Q7+z8wK8=; b=DncKh4CyfMb1HnOkiS643fC0r
	BildCXtQTO/jEdVWCr/PaPy+FpK17q1UN63oOoC4yTXq7bOtY84Xc0dlRXx3jCrQjkIYKP45qlGxL
	/+tlLnKG3M3xCw9SiafediyLgxuWK26WiLnPog6Gk/qiCd9V6ac58kYy1XtmcVSja0u+ZNrCPeaqa
	FFTq7rG8U/P9BCHcNebkU54I7y9P58DN3LXCqUkUOyIUhGqHoDQeKpOOfDgFW1V4EDpkX2IsZr3jM
	pyj+5U0Vf91furSJUolsKZJUYdvL+ZA2iK+dioGlZPUPq9ugnrnVrcyMSqYoEYZrsJYxdvV4d0xsE
	NRwBf8kLQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jahCo-0007mp-2q; Mon, 18 May 2020 14:57:26 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jahCl-0007lj-Sf
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 14:57:25 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589813842;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=37WJcYYeUcY8uB1PDNqJhWLS35uIHhE4CELNFHGw8aw=;
 b=Zk9rUi9DWL3aA/99EBYSbRJdlAnV1moVx5JYO0yEc2UlF25yOH6y8ku7SNAvaFATi6lOGR
 NuA16wX9PZboz7dE6/kbtbAxY3uEq+SgqCWA5PA53E2q2mBc7N1BFuItMuwiSszMn/dvVD
 9+GoExf3NzRbUeG7E2h5M26qk7J0kSQ=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-43-1LP0Xs0KPG2NWIKg5LO7lw-1; Mon, 18 May 2020 10:57:18 -0400
X-MC-Unique: 1LP0Xs0KPG2NWIKg5LO7lw-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com
 [10.5.11.11])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 523C4460;
 Mon, 18 May 2020 14:57:17 +0000 (UTC)
Received: from [10.3.112.213] (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id C9CF56F7E0;
 Mon, 18 May 2020 14:57:16 +0000 (UTC)
Subject: Re: [PATCH v2] nvmet: nvmet_async_events_process always free async
 event to avoid memleak
To: Daniel Wagner <dwagner@suse.de>
References: <1589806918-9711-1-git-send-email-dmilburn@redhat.com>
 <20200518130733.5hfckxyskdom3dsv@beryllium.lan>
 <994479f6-0869-382a-c2b7-64991372c00e@redhat.com>
 <20200518142156.jxxrwtethzn3vvsa@beryllium.lan>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <9c3c4f39-2cd8-176a-d4cc-59205dc4267b@redhat.com>
Date: Mon, 18 May 2020 09:57:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200518142156.jxxrwtethzn3vvsa@beryllium.lan>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_075724_000180_6D58BD48 
X-CRM114-Status: GOOD (  17.59  )
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
Cc: hch@infradead.org, chaitanya.kulkarni@wdc.com,
 linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

Hi Daniel,

On 05/18/2020 09:21 AM, Daniel Wagner wrote:
> Hi David,
> 
>>>> -	while (ctrl->nr_async_event_cmds) {
>>>> +	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
>>>> +		aen = list_first_entry(&ctrl->async_events,
>>>> +				       struct nvmet_async_event, entry);
>>>> +		list_del(&aen->entry);
>>>> +		kfree(aen);
>>>> +
>>>
>>> nvmet_async_event_free() is called from nvmet_sq_destroy(). I thought
>>> this function should free all resources. Wouldn't this leak some memory
>>> if the condition gets false?
>>>
>>
>> It doesn't look like you want to process the nvmet_req if
>> ctrl->nr_async_event_cmds is 0, so making the test a ||
>> may end up bad. It looks like nvmet_add_async_event grabs the
>> ctrl->lock when adding an aen to the list, and it looks like
>> this maybe happening when ctrl->lock is let go before a
>> nvmet_req_complete().
> 
> I admit, I don't really grasp all the details. My concern is that either
> nr_async_event_cmds == 0 and the list is empty or
> nr_async_event_cmds != 0 and the list is not empty. If it is guaranteed
> that those variables are always in sync your change is correct. A more
> defensive way would be do have free the list and the array separately.
> 

It does look like there is still is a chance for the variables to be out
of sync, we will retest with the two separated out in nvmet_async_event_
free().

Thanks,
David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
