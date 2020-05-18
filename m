Return-Path: <SRS0=Nwsb=7A=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70408C433DF
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:16:31 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 2F092207FB
	for <linux-nvme@archiver.kernel.org>; Mon, 18 May 2020 17:16:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="EbYaM02I";
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PeGFwpEm"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 2F092207FB
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=redhat.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=KlJh3baRVJS1z+zz1ugr2M4Prx/GRe//DTO7W/Ll39U=; b=EbYaM02IjhXMEntmsdX1mSXD0
	3klJgC26CFctRafqIgDXycajWa++K0u0e1hW68jGia4lA3HZgXQarOeph2tsITQksotEOuslYPmwT
	ZDmGX8AUrxzV43k2nIWL+M3LhmfE9bWVd7jwxd8+XsMNtnNPOYtWPaPzopjQjHQq75vw+g4Se4Fxy
	aOMFsf9IKiiigQc/hEt+Q85K9CD8JuS2MSCkJ6Q7D4RglpipNPPUSPYBmTgfXr2xh3KbpWHhReW6i
	cHSGEXBlJderoicbQW/9772qf+re+Vg100H3O8Bj55QLruqh+JJUwyHWG3F8ru3W8WIuqA7p5tf8i
	Q8p/bZlZQ==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jajNM-0003hR-B0; Mon, 18 May 2020 17:16:28 +0000
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]
 helo=us-smtp-1.mimecast.com)
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jajNI-0003gX-TY
 for linux-nvme@lists.infradead.org; Mon, 18 May 2020 17:16:27 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1589822183;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=9XmgmFOVtWF1EFUIK9vVDtlhZfwjoTlGdX3/f/CMheg=;
 b=PeGFwpEmcpYbD1WF5IF2KhY7WJqZtyAgK4wOmt6+PB6YG59UWVkHUvgYKjZiXlYwjl4mrF
 hxkk6DlaUPZNPam28Xj/iKmMn2JNRWTNZVHnCTM0YumSIJ7hcAx2DlfR/aUOywbBjAcXuq
 GQESQ903hHXsWULmohiqE8KGRsQhzME=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-103-lJMiY8jBNuWDGh8C2Qa3eQ-1; Mon, 18 May 2020 13:16:21 -0400
X-MC-Unique: lJMiY8jBNuWDGh8C2Qa3eQ-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com
 [10.5.11.13])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BB52C81F420;
 Mon, 18 May 2020 17:16:20 +0000 (UTC)
Received: from [10.3.112.213] (ovpn-112-213.phx2.redhat.com [10.3.112.213])
 by smtp.corp.redhat.com (Postfix) with ESMTP id 33CFD7055D;
 Mon, 18 May 2020 17:16:20 +0000 (UTC)
Subject: Re: [PATCH 1/2] nvmet: check command slot before pulling and freeing
 aen
To: Christoph Hellwig <hch@infradead.org>
References: <1589821386-43424-1-git-send-email-dmilburn@redhat.com>
 <1589821386-43424-2-git-send-email-dmilburn@redhat.com>
 <20200518170700.GA7418@infradead.org>
From: David Milburn <dmilburn@redhat.com>
Message-ID: <cd9b95db-9d1a-640f-d8a6-dc1ef03921df@redhat.com>
Date: Mon, 18 May 2020 12:16:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200518170700.GA7418@infradead.org>
Content-Language: en-US
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200518_101626_045283_AB2C34FE 
X-CRM114-Status: GOOD (  16.16  )
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
Cc: chaitanya.kulkarni@wdc.com, dwagner@suse.de, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 05/18/2020 12:07 PM, Christoph Hellwig wrote:
> On Mon, May 18, 2020 at 12:03:05PM -0500, David Milburn wrote:
>>   static void nvmet_async_events_free(struct nvmet_ctrl *ctrl)
>>   {
>> +	struct nvmet_async_event *aen;
>>   	struct nvmet_req *req;
>>   
>>   	mutex_lock(&ctrl->lock);
>> -	while (ctrl->nr_async_event_cmds) {
>> +	while (ctrl->nr_async_event_cmds && !list_empty(&ctrl->async_events)) {
>> +		aen = list_first_entry(&ctrl->async_events,
>> +				       struct nvmet_async_event, entry);
>> +		list_del(&aen->entry);
>> +		kfree(aen);
>> +	
>>   		req = ctrl->async_event_cmds[--ctrl->nr_async_event_cmds];
>>   		mutex_unlock(&ctrl->lock);
>>   		nvmet_req_complete(req, NVME_SC_INTERNAL | NVME_SC_DNR);
> 
> I don't think this change is correct.  This loop just needs to complete
> all the requests that the host sent.
> 
> The new loop added in the new patch should free any aens still queued
> on ->async_events, but be totally separate from the loop over the
> requests.
> 

Yes, right, sorry I will fix that and resend.

Thanks,
David


_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
