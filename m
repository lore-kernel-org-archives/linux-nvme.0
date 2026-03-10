Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AC10FD2D7D
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 13:27:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=KQMwiNesWOvbkCjUoTZhAGMhdNBr4mXDGAT5peoa0g4=; b=FT5RQ5gE7Ama1BVhJy7xtZTDqb
	g/vRp2TkUWbplVUx9Tpa3VS9f373f2gD8BTuGS9tQ5tAk5wZnARmTD1v3bnHqwT4CV2baatbDgkFg
	BtPAn7ULety6kWMGd18EOeleoDmJ7m35XQYkqXvUjgpWSlshKsrvcruKkxejkQ8V0KOfFWGHNj4BP
	bZMk9ifrT9TvnESBV49hFbNdwbiNn40wixpnSLnef9TS5uD1BqEt787/aIw3YskBFRktv4dOg2uCs
	TOTNylsbFZn5QD4+xMf2JRiDZuUbswwsLXbYxreM5G6q+/96lslXPXqhRl1m8sh1IzMMe929hiCqa
	An14onqg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzx7D-00000009b8v-2GKX;
	Tue, 10 Mar 2026 13:27:15 +0000
Received: from mail-wm1-x334.google.com ([2a00:1450:4864:20::334])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vzx7B-00000009b8b-1RCn
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 13:27:14 +0000
Received: by mail-wm1-x334.google.com with SMTP id 5b1f17b1804b1-48374014a77so152868955e9.3
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 06:27:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773149231; x=1773754031; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KQMwiNesWOvbkCjUoTZhAGMhdNBr4mXDGAT5peoa0g4=;
        b=ApsThm40638IGcfdhEMG+s3c2ho9aV0jHyAQvNZ/1r8lxaWn25qx4xMonN+xoPzgfy
         GyZu5YAHNT41SwegjSvUdo0ho6XJAQgY/Z2gS3XsXmrz57xnOpSMUFdOPxMACvH0oZ1O
         nJr4EGsgU6wStyM5IaGexSqm3sqWIPtoyc7AOO6I7D/e7Ll+v3L8wi0SfTBl0z1WwbkY
         AKkty41EtNX3/kES4wxRQbV5RIPJWNWhBgSWsLyIlHerZEpW5FSghsm2kJOuITKF/CIm
         Rjvr4BcYzsvCLzpD9Xqo9wDawqPxPZZ7S4h9kpYHkS3K6/ovCoqioehFLZ9F3JXf7koO
         c4wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773149231; x=1773754031;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KQMwiNesWOvbkCjUoTZhAGMhdNBr4mXDGAT5peoa0g4=;
        b=o0+DPO5Or0rbYavXFOB/gBn6FhvECXZGPi8yq/AeHULpf/ByJSMnMnBWwHiXV/n84Y
         SW6kgHwbPalMtsAyyMHr5Q638vyi7Irb0P98cVFO2y8NsGUjOvhBVd8Y2UkDyf3vOx+R
         hrlUlbsXj20lHwZEPtIkZ8wbCJkC4s4bo50JRi2doAoP2fRXQ0jLL7k2k+uoTlEnEf5g
         m7F8aZfMIOkQvvINQDzhxYya4hMoISN8EOlKRqzuN63Z4fjPIiANAnGljaszCHn7Etd1
         wlAtgnIuvLpghP00rNDGZC32vgIYoTLHriVq6JaygBWW0LQ7mq2KcCOeLmy4IRaft/Hz
         dlDw==
X-Forwarded-Encrypted: i=1; AJvYcCWFqW/qcwZhOkR96PWh6fboEdznauVilaHwoi3Ovix6crxC6HBW1Zoc+zaNUA7zYEjBK00U/TFBvUU5@lists.infradead.org
X-Gm-Message-State: AOJu0Yy3PBwn6AkF19bs5uJMi+V8k0a02YfCyfYsVGNoPi7C8CdPAY5V
	uR3WPspmhENoNdeDybd4QItyQNyzrIrk//hwkZ9cweuHVxNCyfISinvbjl24XY1bLQQ=
X-Gm-Gg: ATEYQzxzY/UgzXtEYjYcbjKZAlvwaUyXOlyyZVV8765wSQP0BsKESkabXPh7fL0N86V
	jrLbTszLhOcPw5hWrA8BsScNsdEZDYVlq7OqqwSM7/5iPnbE1oPErCrnorqrBOnBCc6Jp+AVr0y
	5wDvFj1nCOMXTtGUrlkT6kdxR/gSBm+Cw+b8LCESl8iXKW0gldrvZpmy+DW9x73vLSq8xGvBOTs
	j+zVDepXfETtX7ZHgpolp+Qk6DC16ctwQ1Jd10xwRlPqwbq+fapwonSypCywEkt/nMBh4u21Zeu
	JCz3KSjtozXB9eKSWK2Gfb7tpqLu31E1iOpYv0cfpmteJohGLn4aCBdU4fGleYOWsKbW2jJqnW8
	aeOhfCsVuASlX7JWhrf24RaD7KVGfAg68DtH+fAS/JDXmOpz2mAbORInLG1fB0Mty8nt40HOP75
	AeQyIDFaW2U7NFHlxI5C4mNf1HJyRby/gkq2DJm7TjBDA6ntKMvim7QlWd
X-Received: by 2002:a05:600d:1a:b0:485:2c61:9457 with SMTP id 5b1f17b1804b1-4852c61be45mr169997465e9.10.1773149231164;
        Tue, 10 Mar 2026 06:27:11 -0700 (PDT)
Received: from ?IPV6:2a07:de40:a101:3:ce70:3e6f:3b9c:9125? ([2a01:4a0:2e:ffff:ffff:ffff:ffff:ffff])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-439dae46353sm42155639f8f.33.2026.03.10.06.27.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 06:27:10 -0700 (PDT)
Message-ID: <c7a62f70-8a69-426e-9947-d2363a124583@suse.com>
Date: Tue, 10 Mar 2026 14:27:09 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 6/8] scsi: scsi-multipath: Maintain sdev->access_state
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
 bmarzins@redhat.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 axboe@fb.com, linux-scsi@vger.kernel.org, michael.christie@oracle.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com
References: <20260310114925.1222263-1-john.g.garry@oracle.com>
 <20260310114925.1222263-7-john.g.garry@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <20260310114925.1222263-7-john.g.garry@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_062713_420089_40055EFA 
X-CRM114-Status: UNSURE (   8.30  )
X-CRM114-Notice: Please train this message.
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

On 3/10/26 12:49, John Garry wrote:
> Now that ALUA is supported, we can maintain sdev->access_state.
> 
> However, preferred_path is still not maintained as that that is related
> to transitioning  state and we do not yet support that (for SCSI
> multipath).
> 
There is an issue with the preferred path in general, namely that it 
overlays the ALUA states (ie you can have 'acive/non-optimized' _and_
the preferred path bit set). So it only makes sense for explicit ALUA
as then the preferred path bit gives us an indicator that we might /
should switch paths.

If we restrict ourselves to implicit ALUA (which I'm advocating anyway
for scsi-multipath) the preferred path becomes rather pointless as
we cannot influence path selection at all.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

