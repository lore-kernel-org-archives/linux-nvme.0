Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2C9A6D59D91
	for <linux-nvme@archiver.kernel.org>; Fri, 12 Dec 2025 20:11:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=NCgRY3rQWWKu/okTJdv9CQLBwy4PnH2zdkYMzdDERp4=; b=cTE8TigNX0Nz7da2Jks9ptTdlL
	/VEeSfN6P8w6gGlID2YXRqUv21+b+WfaRDWXoZPT9aE2dukILyFxR2iyK3VqETG69dTfybKNhXUM/
	MdeIADbGJIVX8pKxXq3kntqoItPkwPCraE9gRwqB9RemZfMLCOBusBW6uq092cZ/sKdaoZQI6iIKu
	bL5rtsYA/RWrn0akbf2K3/6bEN9h47XK16ieANIsvhAnMWMfvED+mlVzd+bkpSatgnP7AsdzxRT6t
	lFVgF+3pbYGj7skclo+KNdkQSlO45Sb4ax1HPlRWSPV6oan5ok1w8NDpFfIrVOgtKB1lWEQprGNuI
	Z1zE1W/A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU9UY-000000012Dd-2YMo;
	Fri, 12 Dec 2025 20:11:54 +0000
Received: from mail-pf1-x434.google.com ([2607:f8b0:4864:20::434])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vU9UW-000000012D0-0ZfG
	for linux-nvme@lists.infradead.org;
	Fri, 12 Dec 2025 20:11:53 +0000
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-7b9c17dd591so1396173b3a.3
        for <linux-nvme@lists.infradead.org>; Fri, 12 Dec 2025 12:11:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20230601.gappssmtp.com; s=20230601; t=1765570311; x=1766175111; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=NCgRY3rQWWKu/okTJdv9CQLBwy4PnH2zdkYMzdDERp4=;
        b=MS1RtzN6o9LsWkL6JI3jKfTmgvqIP4NdYQtCRWf/DnAnv78M+8cTklAIL2ANUW6QVz
         IsEgB+/1YGe/rOe+JMsOpr37wIs4KSGmLNv0TrxjWhUwq7e6CtE9ALBG5/1A35hE2SCG
         P3cou1Xn/N3MmMTWCCmV329bI8RFuxr3GPnpMxUMX1spRVk3jkWuTQJiNiRVrmSywoF1
         dUA0tdIXpvJv8o8FFXQgARYhXCARloIRjon29p6PwLm2U9IhbY/odxIEymvx0hue+dAy
         Lk1CY7Iepgpw7QygF/v+0lPRj49DKBJgdlnNDYv9oGIauiYg1vl0J4XyUwCZGQIS6cPB
         SppA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765570311; x=1766175111;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NCgRY3rQWWKu/okTJdv9CQLBwy4PnH2zdkYMzdDERp4=;
        b=jjNexNpv5x8NoL1UrZm2aienc2KG5WcJyDzeePxYsGSWOGRUc0nHuF8EOX5FkYW9lL
         IzpRAkH2G2xuPaC15h5E5qFEppjmSkmmHHSmf69hEWA5SwmifBJLmjOkB4BLjyYif6/F
         nVMj5J+dE29x7AJYZhHpPOuQGfCcQp8g2Q9LZ0lwP2Inx+sOiQWg/7tukx8x9l2Wc4pO
         /a5E/WIwXiP2jO7Fa0K2y6Ua9TZ9PdD6Dn2MAtuRCHD9cMTdjmYX+paFiTIzT0KqkYbv
         i8vpH8a7pfvWfrhOEW99WMsNgI7RxTHSDsfpbj8RFSQXG7u1HU0SRaS5umDKiKybg67M
         9k+A==
X-Forwarded-Encrypted: i=1; AJvYcCVAipKz1fGk87NlHGRfvS3hSjMHq4AqKoab9d91VEWrQ8+NW+zCQp31CJS5TGC6mSddOD8RrcOCpW2x@lists.infradead.org
X-Gm-Message-State: AOJu0YxH2ydknHHhTnmDz5/4BmxnrN4BLn6VqehXnxcsb0z+gojdfEsX
	9Z9SxCgZFV1KkJHr3dXBTFSk3i/9zrPBRunp7xnXVoNp4z5nnDrUOLNzeHCSvXr+ODg=
X-Gm-Gg: AY/fxX4k1oNhO4AT4NxAY9r3NvcMeovwCUZRZG6VX+wI5DP/O0rq+bRM+d3FkUQZFJ8
	PvhbKHpkdYkR3hzE+0PanA6KC3jux2p+0yQvhdXgvl+SdG8cEMnXTlgA3Btj8S0xBBZlR0Xz+5t
	Gb7i71SoxsSBD3r+yfFV9AgAnrrnNwk66BRNfsfPISTTYt6Q4iduPFiJ2y09w1XIrJN1dOQgdXx
	G0hlD3AOSYYcZaXSyw2Bq9L6mhuN3gmL8CRSrdFV5Zk4kUU9pOy3syCk24iI7OhF56bnaVGrHwA
	x5hjuZLaMX17yNORZFdfsDtCrerhNNIUbZA9kq4sX3buBQB9znXqEdw2tR7zCDXgmh1txzRV+YT
	czzqhDAyF2DZsj8qazFMDNQsYgaS0HFOQzhUTZoI11XKqsV+CkRuzB0I/PDCd68DCoEiRx/HrMv
	K0SkBnXD34ixDd09enrFscSrZocSGkDz6doMpPbo/UQz7SZPU7CA==
X-Google-Smtp-Source: AGHT+IHGJJscBv1tmA5frlmQCAb9BnUJ4d1QiIClXpGlAsDgfMmJ6LAx59zRPGMnF3Hc/v1LWbUgAw==
X-Received: by 2002:a05:701a:ca0b:b0:11b:b3a1:713c with SMTP id a92af1059eb24-11f349a24b8mr2224071c88.9.1765570311149;
        Fri, 12 Dec 2025 12:11:51 -0800 (PST)
Received: from [172.20.4.188] (221x255x142x61.ap221.ftth.ucom.ne.jp. [221.255.142.61])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-11f2e2b46f5sm19902376c88.5.2025.12.12.12.11.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 12 Dec 2025 12:11:50 -0800 (PST)
Message-ID: <d5fbb80b-ed25-476c-a53a-2d9ce98a58ff@kernel.dk>
Date: Fri, 12 Dec 2025 13:11:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] NVMe/TCP: Fixed the out of order H2C PDU Crash
To: Shivam <kumar.shivam43666@gmail.com>, linux-nvme@lists.infradead.org
Cc: sagi@grimberg.me, kch@nvidia.com, hch@lst.de, kbusch@kernel.org,
 gregkh@linuxfoundation.org, Shivam <skumar47@syr.edu>
References: <BL3PR01MB684908447A2F3F7D2AFC57DAC8A3A@BL3PR01MB6849.prod.exchangelabs.com>
 <20251212193124.1022096-1-kumar.shivam43666@gmail.com>
Content-Language: en-US
From: Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20251212193124.1022096-1-kumar.shivam43666@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20251212_121152_179327_C386863C 
X-CRM114-Status: UNSURE (   5.06  )
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

On 12/12/25 12:31 PM, Shivam wrote:
> From: Shivam <skumar47@syr.edu>
> 
> Signed-off-by: Shivam Kumar <skumar47@syr.edu>

You forgot to write an actual commit message.

-- 
Jens Axboe


