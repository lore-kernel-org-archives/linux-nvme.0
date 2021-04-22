Return-Path: <SRS0=aHbv=JT=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4BBBBC433B4
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 07:10:52 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E678A613D8
	for <linux-nvme@archiver.kernel.org>; Thu, 22 Apr 2021 07:10:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E678A613D8
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Transfer-Encoding
	:Content-Type:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:References:Message-ID:
	Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=PGnNv08eLbfOQuRghWjQcSW0x7hxuzFQWFOUpUtj/gM=; b=PwZEGn43iRgY6jlzGON0hidTW
	wO2T4ySJvndHAbjZlpKELVTNeScoKbx8PRRUGuVX5xsHHw9q53f7OCE5bzcoNCAhfKSaZgsmjRPPe
	koUJZMSvpFhZDWFyC3ZjrZVWLSARrKrUGicSRf3PUOdCIg3SI5NKDy5ScqIfXUxscZtKpFRJrQSNq
	rjupReus24QAMSblTw5uh86HHgg107f6uSh2etmq+2MlP3DwGads/F7KSJwlM/0irHAAYg+mvtMTn
	lB9NRJGL1kAjJBaCL+VyKiG65f8IwD7AfCcIPrQjPlqPUVjvRlccHNObVurkaxMt7jboPQCW7z3Ru
	lFAMDxCnw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lZTTs-00G6en-0R; Thu, 22 Apr 2021 07:10:32 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTTp-00G6eP-NT
 for linux-nvme@desiato.infradead.org; Thu, 22 Apr 2021 07:10:29 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Type:MIME-Version
 :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
 Content-Transfer-Encoding:Content-ID:Content-Description;
 bh=0fmBQ9f+8u490hdejAQ6HioXyU9m/fkZSzYVwegeG/U=; b=kWfuRgpv28TSQVhgXysG3Hvary
 GK2CW07AAx8eAGsJMSUHC6H1A9Ol9KIGqcQauGAI6+EFJu23VyRrqG7T6Cgiotb/QeJr6qHCbA9XZ
 lqNpF/LFaUiRZInmQUIIeYetFw2yDRf4/jx9UPPwr2BDZtuFJfP8U8QiZiCusIhD9Hss9Mm0851ZV
 DvWVaf9cq9y3CEN3BSPZHcPjr9KeKnH+008eg2/9Cqp3fnRiJ9EFD4vlfR6i/S/tjkbgPnXdHUBvN
 myMXm8SL4TizN+kyRkTZ3yty5ZU+JzqpUMO91xgsmtbxVjrv2mCyz+XNKdEDe1gBOH5f2bx91xa2q
 Bl2h+M+g==;
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lZTTn-00DRMq-8u
 for linux-nvme@lists.infradead.org; Thu, 22 Apr 2021 07:10:28 +0000
Received: by mail-pf1-x434.google.com with SMTP id y62so7209459pfg.4
 for <linux-nvme@lists.infradead.org>; Thu, 22 Apr 2021 00:10:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=0fmBQ9f+8u490hdejAQ6HioXyU9m/fkZSzYVwegeG/U=;
 b=M4x82gY/vwOURNa/+r2kcUDAUkhshGP7uQmTMki6fludus8rahss6jCgB1rhJ40bfv
 r65gesboiVfGPD3LRYRGx3B3fSpkPSacF1xKgxbVlQ/FeQi+rUgc+IIkQZXcC3IjeqRm
 RL/dh8PW5EJvrU3V0bJP/Fo9+Jx8LuwmGZKBZIaprOzLAUOT4ave/HgIhdk7RaVNJIoq
 Jq0mq4/ehng3YBwLTQviZQHU1Ehm2ubg/j6yPhxTxrRO0ZSWdqxdfwV8qbB03E1t9EWI
 M5QOo56qlco4ieVFHIRnOxhzY26tDvIiNmD4yFXzB4nIgf+xvHW/btWPpTwEHcf7OVpm
 3UzA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=0fmBQ9f+8u490hdejAQ6HioXyU9m/fkZSzYVwegeG/U=;
 b=JSDNnhbKNAlRuyQXFHE9m9D/qBKA+WF8yZguT/0x1TMDh3aeB3P0F57pXjfp4+4n10
 L3bAHPOuj3SN3Rv50n4/xoFvOacOCLGYLoFoO7lloUbLF8Z9k9FX0+knXe0YAxS7Uw5F
 iE0hi4VLUlXXVLZ/vxLl/zizyYHtF8ywbZmPzgMu8E6gD8N/2b2pdT9dUfFqnE0HLysQ
 B23zQMJA2MOjchGtX+rzQbuHisE7noJX7XLltbWtOKCS6l6vLEjJtstopSosA8pF+VHh
 jEhkC7lL5jweTSv4uwdL4rqPJiARhMjAq80+cdL237bjrQkfxRfOcnJUSdaw3Sci8X+s
 upVw==
X-Gm-Message-State: AOAM533U6dUN97MoEp9RlZfkacV5fePBkp2r6GVQbOzAtEYXZ/QpNF3Q
 7w3WkgvjN4AFGmCWzedUOMUfJw0Ki1sPMQ==
X-Google-Smtp-Source: ABdhPJw/SN2CyNdrWYH2phh0pySp+iL8lrcaYKQYHZY7KNh2JqcbBFFYaJuP3Uq/ET0MDEPLy6eEgw==
X-Received: by 2002:a62:868e:0:b029:265:e138:c010 with SMTP id
 x136-20020a62868e0000b0290265e138c010mr2099963pfd.10.1619075425839; 
 Thu, 22 Apr 2021 00:10:25 -0700 (PDT)
Received: from localhost ([58.127.46.74])
 by smtp.gmail.com with ESMTPSA id n16sm1162001pff.119.2021.04.22.00.10.25
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Apr 2021 00:10:25 -0700 (PDT)
Date: Thu, 22 Apr 2021 16:10:23 +0900
From: Minwoo Im <minwoo.im.dev@gmail.com>
To: linux-nvme@lists.infradead.org
Cc: Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
 Christoph Hellwig <hch@lst.de>, Sagi Grimberg <sagi@grimberg.me>
Subject: Re: [PATCH 1/1] Revert "nvme: don't bother to look up a namespace
 for controller ioctls"
Message-ID: <20210422071023.GA26038@localhost>
References: <20210422070735.25855-1-minwoo.im.dev@gmail.com>
 <20210422070735.25855-2-minwoo.im.dev@gmail.com>
MIME-Version: 1.0
Content-Disposition: inline
In-Reply-To: <20210422070735.25855-2-minwoo.im.dev@gmail.com>
User-Agent: Mutt/1.11.4 (2019-03-13)
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210422_001027_334123_4E4E9E3E 
X-CRM114-Status: GOOD (  11.83  )
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

On 21-04-22 16:07:35, Minwoo Im wrote:
> This reverts commit 3557a4409701a132e8f86ad234ac8cf6e97b052e.
> 
> If we simply retrieve namespace from the given subsystem, controller to
> be retrieved might not be the one which is really attached to the given
> namespace.  We should consider the namespace attachment with controllers
> in the subsystem, so this patch simply reverts the previous commit.
> 
> Signed-off-by: Minwoo Im <minwoo.im.dev@gmail.com>

Sorry, I missed the latest nvme-5.13 tree.  This will have conflicts
with the commit 2637baed7801 ("nvme: introduce generic per-namespace
chardev").

Please let me resend it.

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
