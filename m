Return-Path: <SRS0=THed=NL=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BEBC4338F
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 15:28:14 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id ECC9E60F44
	for <linux-nvme@archiver.kernel.org>; Fri, 20 Aug 2021 15:28:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.1 mail.kernel.org ECC9E60F44
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YWzeAasBe3V8ZEKtC1wTppW9GPsYIyItbLlKtrJxjHQ=; b=GSQtSg7d4jDYnITBZJQdtxLb4l
	Z01txxSKZeUN6f01/4yi2Ync7Bw1C/syTIQ2QuF8Dhl2+0wA/LP8jWXqLrRQHYp5OBTB3MFh8tyQA
	ebv6x3pWWjpmAq56McHa2KoTcQg9HcafKe7bDVcAhcaA2xyBI8ApEWwCJXMp9ICMOOrxILOBb43NY
	QxUAdjtD2IKHL5KitSgxDl3YfxbCHF8RY92d/AXMV4eyJgowmwWU6Ro+Qy0i5jTNHvD2/u1oiP4/N
	KkS0HX0zEugDId2Y+D+cmdDnToEoqfGLUkTxeoYs4UHFcliNnx9JVR5QrpV/VCvjU/fAgpcAVPtvH
	sNv0b8bQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mH6RB-00BWdz-9b; Fri, 20 Aug 2021 15:28:05 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mH6Qx-00BWcw-Hp
 for linux-nvme@lists.infradead.org; Fri, 20 Aug 2021 15:27:55 +0000
Received: by mail-pj1-x1032.google.com with SMTP id
 n13-20020a17090a4e0d00b0017946980d8dso13982753pjh.5
 for <linux-nvme@lists.infradead.org>; Fri, 20 Aug 2021 08:27:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=xWUYFVShPfBnoUhetkkSmNUWocaFeL6/9s7+z7WErjc=;
 b=bghtBO7IJBFQP2SOMr7k6cKho3fdH1dZ1vC3B+ySOux1h8a172sFF7xofaaPaGrMoe
 r4giNUdyDZzTMdQ2KvnFfh5Vcp/3NwGyT6rargw2sfQkQ15wVdWeBTRJvafCPilot86o
 obXDCh2+74jQ2GCmL+6BDAQzGksxjgc5wDe3OS/lXHDBFoO17TyoED/dNVItoTUC6nM1
 tDC42Y3mJGa+B6CJ6PaEkb4AZJDKadBLrI+WvRV70AhnUdfqhwqvfcU6m1x4ddycBaeW
 zIeO0NZqzNEVV0LIzuxDFPg4NdpKLHx+vma77rBiJ4R7ECo8zyt2v79R4sHIkbTl99Kd
 DRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=xWUYFVShPfBnoUhetkkSmNUWocaFeL6/9s7+z7WErjc=;
 b=gpsGgvsZ9Y9alokvO3MLcWghjxreqMu7vWCOLUl+DiqXwM5jgc9QrZ68dclEvKof+b
 YO98ETr86bTLMfvY43YHOsTfW3pw9WRyt9GrVYmKReJ5jBIbMaMNQG/VGUCZDnFVjWKH
 BJ4SxKqPwaqN7Ielf93ZqAnXikFEEJyiE7S9e0EcNTKqxohePhv1Njz6SzOwhp3jPvLZ
 kYb1+lkF61ge20H5KocY2By3a7EMG74MO3K2i8JbBNaePv8PIjwetag3dc9UXcANBGGY
 AP9n3CG5LPJjPDMXVsNijTiw7439u7PMempqryDP3lEfb6q4tDD1E1L1/uleUWXwfLzi
 P/+g==
X-Gm-Message-State: AOAM532hwaTW2n+BHE2pvbfhzLH9w1WOYbZ93p1BaiNJMO63xI4RFHrd
 r0mtnlOD3GYWAS9ihSuzaiI=
X-Google-Smtp-Source: ABdhPJxysHeQTtCzXK0dNQgiidOi1ZOG5MX3uXaDcnuxN7BT2yxhF8TCrIcihHJZvUkwVkb0KPSeAw==
X-Received: by 2002:a17:90b:d94:: with SMTP id
 bg20mr5105902pjb.61.1629473269873; 
 Fri, 20 Aug 2021 08:27:49 -0700 (PDT)
Received: from [192.168.1.40] (ip174-67-196-173.oc.oc.cox.net.
 [174.67.196.173])
 by smtp.gmail.com with ESMTPSA id o10sm7984608pgp.68.2021.08.20.08.27.48
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Fri, 20 Aug 2021 08:27:49 -0700 (PDT)
Subject: Re: [PATCH v5 0/3] Handle update hardware queues and queue freeze
 more carefully
To: Daniel Wagner <dwagner@suse.de>, linux-nvme@lists.infradead.org
Cc: linux-kernel@vger.kernel.org, James Smart <james.smart@broadcom.com>,
 Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>,
 Sagi Grimberg <sagi@grimberg.me>, Hannes Reinecke <hare@suse.de>,
 Wen Xiong <wenxiong@us.ibm.com>,
 Himanshu Madhani <himanshu.madhani@oracle.com>
References: <20210818120530.130501-1-dwagner@suse.de>
 <20210820084832.nlsbiztn26fv3b73@carbon.lan>
 <20210820115521.alveifzvad3zuwh4@carbon.lan>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <73a430da-84c8-5457-108a-7e1e2d81fa61@gmail.com>
Date: Fri, 20 Aug 2021 08:27:48 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.12.0
MIME-Version: 1.0
In-Reply-To: <20210820115521.alveifzvad3zuwh4@carbon.lan>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210820_082751_644534_F57F4750 
X-CRM114-Status: GOOD (  25.16  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 8/20/2021 4:55 AM, Daniel Wagner wrote:
> On Fri, Aug 20, 2021 at 10:48:32AM +0200, Daniel Wagner wrote:
>> Then we try to do the same thing again which fails, thus we never
>> make progress.
>>
>> So clearly we need to update number of queues at one point. What would
>> be the right thing to do here? As I understood we need to be careful
>> with frozen requests. Can we abort them (is this even possible in this
>> state?) and requeue them before we update the queue numbers?
> 
> After starring a bit longer at the reset path, I think there is no
> pending request in any queue. nvme_fc_delete_association() calls
> __nvme_fc_abort_outstanding_ios() which makes sure all queues are
> drained (usage counter is 0). Also it clears the NVME_FC_Q_LIVE bit,
> which prevents further request added to queues.

yes, as long as we haven't attempted to create the io queues via 
nvme_fc_connect_io_queues(), nothing should be successful queueing and 
running down the hctx to start the io. nvme_fc_connect_io_queues() will 
use the queue for the Connect cmd, which is probably what generated the 
prior -16389 error.

Which says:"nvme-fc: Update hardware queues before using them" should be 
good to use.

> 
> I start wonder why we have to do the nvme_start_freeze() in the first
> place and why we want to wait for the freeze. 88e837ed0f1f ("nvme-fc:
> wait for queues to freeze before calling update_hr_hw_queues") doesn't
> really tell why we need wait for the freeze.

I think that is probably going to be true as well - no need to 
freeze/unfreeze around this path.  This was also a rather late add (last 
oct), so we had been running without the freezes for a long time, 
granted few devices change their queue counts.

I'll have to see if I can find what prompted the change. At first blush, 
I'm fine reverting it.

> 
> Given we know the usage counter of the queues is 0, I think we are
> safe to move the blk_mq_update_nr_hw_queues() before the start queue
> code. Also note nvme_fc_create_hw_io_queues() calls
> blk_mq_freeze_queue() but it wont block as we are sure there is no
> pending request.

Agree.

-- james

> 
> _______________________________________________
> Linux-nvme mailing list
> Linux-nvme@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-nvme
> 


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
