Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64DCBC54798
	for <linux-nvme@archiver.kernel.org>; Thu,  7 Mar 2024 12:03:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=ppDSbdzrH/zrYwV5YVqxaBw09z7ks8avz/iELkEb5fA=; b=TvcXyWmtDbltb9j6J9i0D1eNP1
	AxXXys8U4W2xbIcTKEoOGtfCHKc2blTJrhuz0Z7rJsdwMLrfbD2c9P96XUKTPxHQOeO7mqleQndC+
	faSh5Fy1hcih7QgL4eN0RHJp+QEWZiDE/Lp5V80cTqQ+Mct7Vr8WbdcNdaXUzZ9YBr94CwPyAyJMW
	HEgUTSeRkNYO+KlJor2LqPSGsfQlZ5lPkVNEBaIvaqvE/5r0KShZlCD/MWIO302wgXu2w3GYl/APn
	+TeXGvksfr1Ap/YCfjIRWuaX6BnlI0zUMfL1c7aob0WQzKoY12tzVraac3elEBpo+RkbloZ75BYiN
	g2ZtgZIw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCTY-00000004TqE-2YWU;
	Thu, 07 Mar 2024 12:03:52 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
	by bombadil.infradead.org with esmtps (Exim 4.97.1 #2 (Red Hat Linux))
	id 1riCTW-00000004Tpn-1WaA
	for linux-nvme@lists.infradead.org;
	Thu, 07 Mar 2024 12:03:51 +0000
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-412e41cab5aso377945e9.1
        for <linux-nvme@lists.infradead.org>; Thu, 07 Mar 2024 04:03:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709813028; x=1710417828;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ppDSbdzrH/zrYwV5YVqxaBw09z7ks8avz/iELkEb5fA=;
        b=PDQpd84aFWw+5BRnSlOBIY46OEbtMxKnP24RPNtqyBkdFKBXhl68u8HQlTxVxoqpRO
         B10gFpRdjmN6HVrNwUJ9NdNM2j9kjv1M13W2VwyxwBiiY2pUNiXuF3KnIpVa4MNOQAhG
         TJyJFl8EiP6lLZY/YENVoyLhzFffKTXpCEDoFx9iCiep4bu4vWvbMr25v7EugoEFGjIP
         w1BUQzTZWlD/Jw1Z1HA2fEMEswbFqwgmc6dsr1H5UhDo6nmBbp15GpvNRqPXauDnBPQv
         uiMOZyIwFoxFmG7ibclj/RJAcLJQeTFtuoDDmxz3nf7oe/+aUl9Ck2MQrZdZq0F7shO0
         zdfw==
X-Forwarded-Encrypted: i=1; AJvYcCVCMmAm8AlUHjFtVM4Ajx8CBqJbiMg/9EuMa2jpsyVZ4BnDDT8Jvds1RsjGipffHIK1G81dM7uFPE4g6HMXkr4qGy5ttIcFCUOupcz/Hbs=
X-Gm-Message-State: AOJu0Yy09wHzEIOYm3Gry0xr4dTBSnjONog9y8E/C9QO7db7Q4xP9fte
	SjjpL0tkEQlz3NdwfIWzTgh/CWTyI03fN5/Z8XYVk1CDsB4U6vug
X-Google-Smtp-Source: AGHT+IHcp/bEwcbctPAJiXrGKFOy5qd+hq3jcqOReGa6G2XPpyrrgK414zbF2V71JFVOtuqBRi0daw==
X-Received: by 2002:a05:600c:3ba8:b0:412:eb6e:2171 with SMTP id n40-20020a05600c3ba800b00412eb6e2171mr1281123wms.1.1709813028406;
        Thu, 07 Mar 2024 04:03:48 -0800 (PST)
Received: from [10.100.102.74] (46-117-80-176.bb.netvision.net.il. [46.117.80.176])
        by smtp.gmail.com with ESMTPSA id q8-20020a05600c46c800b00412d60cb914sm2514816wmo.5.2024.03.07.04.03.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 07 Mar 2024 04:03:48 -0800 (PST)
Message-ID: <66a4f2b8-9e2b-4734-b1a1-083bd69411c7@grimberg.me>
Date: Thu, 7 Mar 2024 14:03:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 3/4] nvmet: return DHCHAP status codes from
 nvmet_setup_auth()
Content-Language: he-IL, en-US
To: Hannes Reinecke <hare@suse.de>, Hannes Reinecke <hare@kernel.org>,
 Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20240301112823.132570-1-hare@kernel.org>
 <20240301112823.132570-4-hare@kernel.org>
 <38d98acc-4042-4fef-af1d-cee2eccc98d8@grimberg.me>
 <90c1e888-af15-4c89-9839-68d128d963d6@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <90c1e888-af15-4c89-9839-68d128d963d6@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20240307_040350_441280_E125BBBF 
X-CRM114-Status: GOOD (  12.30  )
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



On 07/03/2024 13:19, Hannes Reinecke wrote:
> On 3/7/24 09:56, Sagi Grimberg wrote:
>>
>>
>> On 01/03/2024 13:28, Hannes Reinecke wrote:
>>> A failure in nvmet_setup_auth() does not mean that the NVMe
>>> authentication command failed, so we should rather return a
>>> protocol error with a 'failure1' response than an NVMe status.
>>
>> Shouldn't nvmet reply NVME_SC_INTERNAL like in other similar
>> cases?
>
> No. NVME_SC_INTERNAL will be converted into a status code for the 
> authentication _command_, indicating that the authentication
> _command_ encountered an error.
> But authentication _command_ is fine (ie it got send and received
> okay). It's the authentication itself which failed, so we need to
> return an authentication protocol failure state.

Yes, I guess I was specifically asking about the failure to setup_auth 
in the re-auth case...

