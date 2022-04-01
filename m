Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD6AFC433EF
	for <linux-nvme@archiver.kernel.org>; Fri,  1 Apr 2022 01:23:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YOOADrKp+VUH8nQO7+wMgoqOiNsAto5K2zBbiDRvBQA=; b=fUKha9qgnyV8OLyBsH+5EFqAOm
	NevhuE+hBHKRJLvCh46507SjyOy1AJiKHJOMYbIq+J84Czge77L9KFxoSZazo3ltrmOboXMangfVc
	yCkZLpVdj91QrqHAanEUNclaRznRdQk9iKz9Ka3GukdLKuEf8IPm3k3oVdSpXasJGSxq+0mmPIpDT
	GDgPTYBQhzJCay3eYPYlTY6yddCyBDEFuuR7Oqc3Y0JNcC5Rb5Mx0A8UyvoDVPXRYK/puZ4j5r3km
	o/n+A8J4rE1OPKNP5bsy+L70zXsC1ZSAfB/a334tI8mioTUdcGZtcqXHZa6jSHVJEgRmDUzNrVozW
	PUjM5Usw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1na60u-0049dj-Fp; Fri, 01 Apr 2022 01:23:44 +0000
Received: from mail-pj1-x1032.google.com ([2607:f8b0:4864:20::1032])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1na60q-0049cD-KN
 for linux-nvme@lists.infradead.org; Fri, 01 Apr 2022 01:23:42 +0000
Received: by mail-pj1-x1032.google.com with SMTP id
 mp11-20020a17090b190b00b001c79aa8fac4so4203156pjb.0
 for <linux-nvme@lists.infradead.org>; Thu, 31 Mar 2022 18:23:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=kernel-dk.20210112.gappssmtp.com; s=20210112;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=YOOADrKp+VUH8nQO7+wMgoqOiNsAto5K2zBbiDRvBQA=;
 b=P5BxKWEahEPPwlw9a0QpM7zhhBpUCCEILLqvIR/xRoAa3YvZpOhKP+yXYRBNCX9ow0
 6NsaY3Ylj1u/LcftP5yMzqWPd5RGrwhphqdoWoprMMtYcqFq8O9kz1BHf7x1jW1PT9va
 0/j3dE0tY3Izu0mIwiN2CcxdkelYk5Q/mlLhsiaKaticT+8l4vcP+SKhh7YKplYuqaDD
 m9ADLE4Jx8aUxaf5JVFA6J7qbO1Gwcrv7rG3YLmAmPCglJGQNMWYR71HPQmpn/fXkbox
 8MpSHFY7mYqwz7Xs7tyx1uY37iC+4bcy6wkrHcX5hqC2/ax40Qx6wGzV2jGZhsCPEYSb
 eFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=YOOADrKp+VUH8nQO7+wMgoqOiNsAto5K2zBbiDRvBQA=;
 b=vpLNWhSR7dfxyG9M0JFsPBZLRP8Z/SLutUHSsPlf0Yd7m6Wy6ORSa832CyzIpieUMQ
 azW9R8yyMID8ExfUb4YluQDGsHIlJ2/eEVq4jWxf9cHQ8le6D48Xc0E12WPMXkCKyYW4
 bLhmD+JlzSaKeLVnZfkz4zOvsJpAh5HGUG04zWa1r5NemOUxnVISVNHVtpCDhomIL+VH
 kmveI3HrSQKP7jL69ecNP/Z+5l+CD7p2hVQkIGvCqUbV17wLYF1c08plyx6xOYQIM6tG
 A4TfJ6Bcc8MSwi1XKuFfouORCWPSIq4rDcqRFzRiQcw32TFlrp082CaJ1KY0L4WuSB/v
 3Kog==
X-Gm-Message-State: AOAM53271e3UDhhv+Y2FhN7hhc3FJYELd90w9grOm+Vx5hCdGhknxst4
 Wj4KNQIwCJ+I5oo4jGY6Vo6nBA==
X-Google-Smtp-Source: ABdhPJyk/iqyzfWVXReArPDPtUOmxZ6AqZAFhyA9YOyL8iLIs3KsI+YBk4BVzOcEA2hz0c81JcEaRQ==
X-Received: by 2002:a17:903:1249:b0:154:c472:de76 with SMTP id
 u9-20020a170903124900b00154c472de76mr42608330plh.81.1648776218273; 
 Thu, 31 Mar 2022 18:23:38 -0700 (PDT)
Received: from [192.168.1.100] ([198.8.77.157])
 by smtp.gmail.com with ESMTPSA id
 a38-20020a056a001d2600b004fae885424dsm718823pfx.72.2022.03.31.18.23.36
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 31 Mar 2022 18:23:37 -0700 (PDT)
Message-ID: <30eea8a2-2bd0-7aa2-42a1-523c61de563c@kernel.dk>
Date: Thu, 31 Mar 2022 19:23:36 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 17/17] nvme: enable non-inline passthru commands
Content-Language: en-US
To: Christoph Hellwig <hch@lst.de>, Kanchan Joshi <joshi.k@samsung.com>
Cc: Kanchan Joshi <joshiiitr@gmail.com>, Keith Busch <kbusch@kernel.org>,
 Pavel Begunkov <asml.silence@gmail.com>, io-uring@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-block@vger.kernel.org,
 sbates@raithlin.com, logang@deltatee.com, Pankaj Raghav
 <pankydev8@gmail.com>, =?UTF-8?Q?Javier_Gonz=c3=a1lez?=
 <javier@javigon.com>, Luis Chamberlain <mcgrof@kernel.org>,
 Adam Manzanares <a.manzanares@samsung.com>, Anuj Gupta <anuj20.g@samsung.com>
References: <CGME20220308152729epcas5p17e82d59c68076eb46b5ef658619d65e3@epcas5p1.samsung.com>
 <20220308152105.309618-18-joshi.k@samsung.com>
 <20220310083652.GF26614@lst.de>
 <CA+1E3rLaQstG8LWUyJrbK5Qz+AnNpOnAyoK-7H5foFm67BJeFA@mail.gmail.com>
 <20220310141945.GA890@lst.de>
 <CA+1E3rL3Q2noHW-cD20SZyo9EqbzjF54F6TgZoUMMuZGkhkqnw@mail.gmail.com>
 <20220311062710.GA17232@lst.de>
 <CA+1E3rLGwHFbdbSTJBfWrw6RLErwcT2zPxGmmWbcLUj2y=16Qg@mail.gmail.com>
 <20220324063218.GC12660@lst.de> <20220325133921.GA13818@test-zns>
 <20220330130219.GB1938@lst.de>
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220330130219.GB1938@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220331_182340_722376_50675EA1 
X-CRM114-Status: GOOD (  14.34  )
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

On 3/30/22 7:02 AM, Christoph Hellwig wrote:
> On Fri, Mar 25, 2022 at 07:09:21PM +0530, Kanchan Joshi wrote:
>> Ok. If you are open to take new opcode/struct route, that is all we
>> require to pair with big-sqe and have this sorted. How about this -
> 
> I would much, much, much prefer to support a bigger CQE.  Having
> a pointer in there just creates a fair amount of overhead and
> really does not fit into the model nvme and io_uring use.
> 
> But yes, if we did not go down that route that would be the structure
> that is needed.

IMHO doing 32-byte CQEs is the only sane choice here, I would not
entertain anything else.

-- 
Jens Axboe


