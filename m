Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 56ACCC433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 27 Apr 2022 15:05:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=3t/sLcxk5ON+nCAOFqDjHqbbXWr7HEuBu+6M9wcEXV8=; b=DTUyAGJGnZqw1ZYbQ/MqhLJv71
	M42UakGW3yTq5ULA56e328wULWODxReAemRzxdsOt83VCRdMaxLFiReswzHwLPSzeZfFB1n/P2wYb
	f6bCz/XlUvHmV7aWVJkY8aDNOiar9Md1Xr6MPY3VGJjldsE6ufBZm98SVWXwXWGHNCYUZkbNA44z6
	vq+gmM5g2tWL+kNdpHYxstJXmFtF/tZyGpziBzECcJFjQ3mMJybOIiUkfqv7vnRetRmBH35+ybZLZ
	/WgY1huIcVy02RbkE3jy44EmxBoV3fnnk+Jx7Otf3F8M2gGV+Cii74ytA1oQwC0MibX5ASc2VgiPl
	0SriYO0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1njjEX-001uDG-Go; Wed, 27 Apr 2022 15:05:37 +0000
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1njjET-001uCT-HV
 for linux-nvme@lists.infradead.org; Wed, 27 Apr 2022 15:05:35 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1651071932;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=3t/sLcxk5ON+nCAOFqDjHqbbXWr7HEuBu+6M9wcEXV8=;
 b=RCjuKPo24WbpulEqEAHMcnF4mRNXiRdg06g3UX0u09GGp/Mhk82+SxNZSybYupc30h5gj8
 oZpeRv3XfQm5XSU2Jvrsy0ov49TBUDmpEz7GU221Lfngl79RIfgh8K/C//MJ6owfv+WbGp
 AWpHPUvsT/JOH0W3e4/gG0m2AjKbh/4=
Received: from mail-ej1-f71.google.com (mail-ej1-f71.google.com
 [209.85.218.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-433-ovbXOcrAOby7a7RxSqeP5Q-1; Wed, 27 Apr 2022 11:05:31 -0400
X-MC-Unique: ovbXOcrAOby7a7RxSqeP5Q-1
Received: by mail-ej1-f71.google.com with SMTP id
 sb36-20020a1709076da400b006f3d4b12d3aso213314ejc.5
 for <linux-nvme@lists.infradead.org>; Wed, 27 Apr 2022 08:05:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=3t/sLcxk5ON+nCAOFqDjHqbbXWr7HEuBu+6M9wcEXV8=;
 b=5ajyyGNz63EHfXOS+IUDAxFx7GMxcexhv7aFG8SGxyofig9mih9VdWd/ASs3Tw6ZM4
 ol5cKWWRoj0J6vugE4GCYUl4wPdAnOwvXDoep7P3kHNgrlN71ch3tjne/aHnmUSEIgnU
 81s2MerMD0VGCCNPdjtnIyRTV49M289gwUp1Q6bVbK8NY6DOG9k2NZhv4DMMwU6BcLmD
 g4Bk0dLb91bHpnYAPyQX2BbCGkc6Fc191hPOSEICN+Dnv3Oi1D+4rTTINdACJyFeLtLl
 EgoZlMraiPBpSPSlGZD+uxenjNjcLwAe/7GsH8omnWes3VWRGgay2UxV3+4y1sni7Pnp
 6XWw==
X-Gm-Message-State: AOAM5301MWpf6Zqp+o0a3VcGl9KR3x6Rnoo09J7cYIP6gTg2A+nhTj9U
 g568N+qG93c/YfiNllbW2VMFIZz8OXBZZunrAXfrG1eo3hbRkSu/qi7T+V9wxT3QunLeJeUGGoF
 uRQ6d9hqMHZv/iDOD3nWmzZ+WRFY=
X-Received: by 2002:a17:906:1b1b:b0:6f3:9044:5fb4 with SMTP id
 o27-20020a1709061b1b00b006f390445fb4mr15892654ejg.763.1651071929708; 
 Wed, 27 Apr 2022 08:05:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxW6QYNB9mO1C2n0d8BB/YK/nWa+lxH0HlS4zgjNQP35Gfh0Ka65UPPL3YcQEW3fJBKBrFN3A==
X-Received: by 2002:a17:906:1b1b:b0:6f3:9044:5fb4 with SMTP id
 o27-20020a1709061b1b00b006f390445fb4mr15892643ejg.763.1651071929527; 
 Wed, 27 Apr 2022 08:05:29 -0700 (PDT)
Received: from ?IPV6:2001:1c00:c1e:bf00:d69d:5353:dba5:ee81?
 (2001-1c00-0c1e-bf00-d69d-5353-dba5-ee81.cable.dynamic.v6.ziggo.nl.
 [2001:1c00:c1e:bf00:d69d:5353:dba5:ee81])
 by smtp.gmail.com with ESMTPSA id
 c2-20020a170906924200b006f3d1141693sm656369ejx.44.2022.04.27.08.05.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 27 Apr 2022 08:05:28 -0700 (PDT)
Message-ID: <1c5df3fc-98a3-5cc4-a542-1c8920e709e5@redhat.com>
Date: Wed, 27 Apr 2022 17:05:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: PCIE ASPM-related trouble with S0ix on Thinkpad X1 (NVME-related?)
To: =?UTF-8?Q?Toke_H=c3=b8iland-J=c3=b8rgensen?= <toke@toke.dk>,
 "Box, David E" <david.e.box@intel.com>, "Wang, Wendy" <wendy.wang@intel.com>
Cc: "platform-driver-x86@vger.kernel.org"
 <platform-driver-x86@vger.kernel.org>,
 "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <87k0bvutxf.fsf@toke.dk>
 <MW3PR11MB4522A97808B70EFA41122723A1ED9@MW3PR11MB4522.namprd11.prod.outlook.com>
 <8735ii384z.fsf@toke.dk>
From: Hans de Goede <hdegoede@redhat.com>
In-Reply-To: <8735ii384z.fsf@toke.dk>
Authentication-Results: relay.mimecast.com;
 auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=hdegoede@redhat.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: redhat.com
Content-Language: en-US
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220427_080533_917859_BA03E01C 
X-CRM114-Status: UNSURE (   8.60  )
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

Hi All,

On 4/12/22 12:31, Toke Høiland-Jørgensen wrote:
> "Box, David E" <david.e.box@intel.com> writes:
> 
>> There are a few things that could be going on. Please file a bug
>> report at bugzilla.kernel.org under Power Management. Provide all this
>> information and include the output from lspci -vvv when ran as root.
>> Thanks.
> 
> Alright, thanks! Opened
> https://bugzilla.kernel.org/show_bug.cgi?id=215832

David, Toke has provided the requested info at the above bugreport,
but sofar no-one has responded to this bug report yet.

Can you respond / follow up with Toke in the bug report please?

Regards,

Hans


