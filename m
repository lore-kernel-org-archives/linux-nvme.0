Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CDA3DCF6D2C
	for <linux-nvme@archiver.kernel.org>; Wed,  2 Oct 2024 15:03:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=YN8tLxTNLoc6Z+6iyULY22+FNGpb/PmZBsYC0aDr5nk=; b=mX/cwbmsTQBAit5OXKNb59TUjK
	Wdd7ldAgG2ljKj/NqIaOy+V2t7oY80iKDKvzMHbxy9VqoeP29+DuHXjo48vGydVJabHbAFBwkyKRv
	Rdkk91XKag5VRty4J3BM+9nTUghJmxHu1QrWBA1oZA8wcLWoO0X8HOEwMLVXsPwLHBP6VvX1PYW8h
	WwE7RezYW1FJcnwoNWB83kNHkWOw3jNSL+mDVxhQ23Ada3UMCwTfN54aslP1OvpW15TUEAqTDctTw
	Wx7hDelLFT28nqi5iGWumfCFrdXw2eDzb0zOuI+Lq/JZ/Kxx/PYe9jCA//7qkT096hkVmGyt8Vz96
	NcRxA+Cw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0t4-00000006Wji-1cyS;
	Wed, 02 Oct 2024 15:03:34 +0000
Received: from mail-io1-xd31.google.com ([2607:f8b0:4864:20::d31])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1sw0sv-00000006Wg1-43yy
	for linux-nvme@lists.infradead.org;
	Wed, 02 Oct 2024 15:03:27 +0000
Received: by mail-io1-xd31.google.com with SMTP id ca18e2360f4ac-83255877364so413408839f.1
        for <linux-nvme@lists.infradead.org>; Wed, 02 Oct 2024 08:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1727881404; x=1728486204; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YN8tLxTNLoc6Z+6iyULY22+FNGpb/PmZBsYC0aDr5nk=;
        b=SknlXhzAGWfwlMnvDo+PKYC8VdMn0Bff/V8ema4Z/K/ozpBy5BQ7nlCbr+E0VwOOdW
         uPW0LhONxVRyc/zWHN8E3H1N0aE30mtvc56iFNvxy+UCmeVscpRNZxrESJ0/NsA11UxN
         StGSqT1PXhnQ9R6dMrT4PLxWWtkBXJTNqe1lGGf+6zcoKunXebr7JW9lV6ctQeABLXaM
         z4lrPCxNMtx950aALenm82AL4OnHCTyDiyE92lXHW3cGeMxwGfGFdss+1pGAxDFhhNif
         6s9321gcfwS04w4uqFNtT9zHOHqufUCWM84Cv9QMkvJ+gyJb5apZegurI82VgJTHyWDY
         7SZw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1727881404; x=1728486204;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YN8tLxTNLoc6Z+6iyULY22+FNGpb/PmZBsYC0aDr5nk=;
        b=N1L8uVLhyjhRglYHdGTQk1g/gGU1IZgSGX/8joW1xyxB+6rbza1kw9/FU0Hpbt7wMb
         y24YASDbh3X4vuRJ//hWuPcsIXqHEoApHvfLXA5Gg/2/h5+b8AQTQxTeUBSh/jvtFmnw
         z/KlBbNl/Mp06jSHAdCU6FONo1FMPxygU97rzOSbeDkd9cPuGQbctalIiThCs8Qo8+en
         t02zQ7U53x7Xp6caUWKca7Hwl27saQpqtRy/XWZhwpeJfTEz7nlzmScJ1OmwRDtEWYVq
         L9An+2+UlogJNOMA8leAr8GEo3jQuyjAkxKSaStkQOkyiwyU9OBeT5xa/RDL+EXFaQZe
         sDfw==
X-Forwarded-Encrypted: i=1; AJvYcCWyAz8Kz3ZCsUj5rKvYS8foQGt6rk4U+/O3UOoOglGL4WOuT72SIO/82mb8fqUrGqR1o/pp01GOZSNc@lists.infradead.org
X-Gm-Message-State: AOJu0YztuxxIVWAonTlDS/MuhON9jtn4wcEiHa8WqWJfLNe/qca2Jiiw
	U9UuvASUdpuLwVm0Ake9nvGOYaVdB5qrzgES9IUJwkwOLk1wrZdvimo8phwUhYA=
X-Google-Smtp-Source: AGHT+IHxepFVron7PObO0zlx42lsa/dU5NCcXVtGwmYpMS9i6sDKEx8F2iCKxC41JSaFOYey3Om7Gw==
X-Received: by 2002:a05:6602:60c1:b0:82d:8a8:b97 with SMTP id ca18e2360f4ac-834d8519045mr390417439f.10.1727881404221;
        Wed, 02 Oct 2024 08:03:24 -0700 (PDT)
Received: from [192.168.1.116] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id ca18e2360f4ac-834936c8597sm334094439f.16.2024.10.02.08.03.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Oct 2024 08:03:23 -0700 (PDT)
Message-ID: <f14a246b-10bf-40c1-bf8f-19101194a6dc@kernel.dk>
Date: Wed, 2 Oct 2024 09:03:22 -0600
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v7 0/3] FDP and per-io hints
To: Christoph Hellwig <hch@lst.de>
Cc: Kanchan Joshi <joshi.k@samsung.com>, kbusch@kernel.org, hare@suse.de,
 sagi@grimberg.me, martin.petersen@oracle.com, brauner@kernel.org,
 viro@zeniv.linux.org.uk, jack@suse.cz, jaegeuk@kernel.org, bcrl@kvack.org,
 dhowells@redhat.com, bvanassche@acm.org, asml.silence@gmail.com,
 linux-nvme@lists.infradead.org, linux-fsdevel@vger.kernel.org,
 io-uring@vger.kernel.org, linux-block@vger.kernel.org, linux-aio@kvack.org,
 gost.dev@samsung.com, vishak.g@samsung.com, javier.gonz@samsung.com
References: <CGME20240930182052epcas5p37edefa7556b87c3fbb543275756ac736@epcas5p3.samsung.com>
 <20240930181305.17286-1-joshi.k@samsung.com> <20241001092047.GA23730@lst.de>
 <99c95f26-d6fb-4354-822d-eac94fdba765@kernel.dk>
 <20241002075140.GB20819@lst.de>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20241002075140.GB20819@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241002_080326_047248_C91644A3 
X-CRM114-Status: GOOD (  16.01  )
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

On 10/2/24 1:51 AM, Christoph Hellwig wrote:
> On Tue, Oct 01, 2024 at 10:18:41AM -0600, Jens Axboe wrote:
>> Have to say, that neither have your responses been. Can't really fault
>> people for just giving up at some point, when no productive end seems to
>> be in sight.
> 
> I heavily disagree and take offence on that.
> 
> The previous stream separation approach made total sense, but just
> needed a fair amount of work.  But it closely matches how things work
> at the hardware and file system level, so it was the right approach.

What am I missing that makes this effort that different from streams?
Both are a lifetime hint.

> Suddenly dropping that and ignoring all comments really feels like
> someone urgently needs to pull a marketing stunt here.

I think someone is just trying to finally get this feature in, so it
can get used by customers, after many months of fairly unproductive
discussion.

-- 
Jens Axboe


