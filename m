Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BA8D7C433EF
	for <linux-nvme@archiver.kernel.org>; Mon, 22 Nov 2021 10:01:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7BH913p0kCNjWhJQSwXzkEvjGX5q7bgdHRFIxvVYVKU=; b=mBHnbb7vpkZz6XZoPtuGqBdJTi
	6qX2cdI3t/y2rQoR5+AOFUhOl9PpCR2bGOAv5ESF8nIwj5dLtZHnUxdsaNY35Z0Nixjp+PLEtcVdH
	Qf/ZY87wpU1hDPt4F452j/A79jfXcI3GTg4KEXd0D+JJCEv7xKEKWIBP5688OuHvzv6T/22BxVw4f
	gpC2YgPMVZMF2xL+jWw2SBOKyAsDPi+bfbxrfaI4hFiIF4msNhdwywK0s78cYGKA960S16g5voehU
	bYuf/sbEMrPvzpx1WEWS6zzIIdXlywSsHJ783zNfSSN0oW0afY6D/Q4XIzHJRNtiOQ0o/bPpj9CZ0
	74MbS5Pg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mp687-00Fk0R-QQ; Mon, 22 Nov 2021 10:00:55 +0000
Received: from mail-wm1-f51.google.com ([209.85.128.51])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mp5o7-00Fe7n-FL
 for linux-nvme@lists.infradead.org; Mon, 22 Nov 2021 09:40:16 +0000
Received: by mail-wm1-f51.google.com with SMTP id y196so14629597wmc.3
 for <linux-nvme@lists.infradead.org>; Mon, 22 Nov 2021 01:40:15 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=7BH913p0kCNjWhJQSwXzkEvjGX5q7bgdHRFIxvVYVKU=;
 b=Hjrd0fHy38tA69r9tQqjBfEoiEBM7j/Aaaq9dP5BVtw3tmpoeZhBd6gZ7uCfFgcxlJ
 g8ORb25/52Ibj1Ed5OFNLTcebth+LRlj3lQdFRpZ8TSspQyZE2AjRTC+ypr09soCyNDF
 zLZdKrz3lNOCYJeLdXwPW6gFSrBWAOuvBOcPc1NJjXTFypB4+Z/x/IsD/few5XTiljsB
 WIYRA+Vqk2QyJJP3qTRIUuTYE4KSZOPl991Dcr8RZrR1LPB6f6lQJ1hvIYQ8Bs2wcu1g
 YIomkNq01sfO5bVKn2baHB2zpJS5jjOpo6bBqnHUWiujiulLSbxTu5GMXENPBE/Kkm6L
 43ug==
X-Gm-Message-State: AOAM530e4goH0fDJDAmJFy0jAz3g1dXyRt2YUQ95ao7UgQuGYAEkA1rH
 ZeA0F+W3ZSLjltkSwzSaH5Gqh32jltU=
X-Google-Smtp-Source: ABdhPJwZo3f9WeVdD+rJkVGl8hu/OgrDKRoZdUOX0zbnmPFikNMn30f3k5uB+BD6c2WxdCRq++jD/w==
X-Received: by 2002:a1c:770e:: with SMTP id t14mr26627539wmi.173.1637574013751; 
 Mon, 22 Nov 2021 01:40:13 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id g13sm11057279wrd.57.2021.11.22.01.40.13
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Mon, 22 Nov 2021 01:40:13 -0800 (PST)
Subject: Re: [PATCH 4/9] nvme/039: simple test for nvmeof-tcp connection
To: Hannes Reinecke <hare@suse.de>
Cc: Christoph Hellwig <hch@lst.de>, Keith Busch <keith.busch@wdc.com>,
 Omar Sandoval <osandov@fb.com>, linux-nvme@lists.infradead.org
References: <20211122075524.26207-1-hare@suse.de>
 <20211122075524.26207-5-hare@suse.de>
 <197826e6-273c-6f19-f5cf-44814433976c@grimberg.me>
 <f5e414cd-c60c-442a-01c5-dfb0c1422b17@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <3aac418e-339a-1cc6-8b29-456be0174234@grimberg.me>
Date: Mon, 22 Nov 2021 11:40:12 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <f5e414cd-c60c-442a-01c5-dfb0c1422b17@suse.de>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211122_014015_583477_2E666D15 
X-CRM114-Status: GOOD (  11.90  )
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


>>> +DESCRIPTION="Create single TCP connection via localhost"
>>
>> Why is this test needed?
> 
> To establish a baseline that I didn't mess up _normal_ connections when
> adding the authentication stuff.
> But yeah, I can fold it in with the next test.

This is something all other tests already do though...

