Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C6DBC2A069
	for <linux-nvme@archiver.kernel.org>; Sun,  4 Jan 2026 21:14:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qNq8Dlg9dgt9AwcFJgT9Gsr/YTM893QKcON0HPwwdp8=; b=acen6Q4NMBIovPGq/0fl7DBRzW
	xxsRw+1JlqvankvwGyZr3q9oscVot2rU5L21nLxHT2j8zrhoofv6DoUzirtQm1o3tmwAhgTv6d4x0
	UNwfu7tB63/L16H0EwZeSGfqeC0QvDsbNWvYYdFGYoipAcrGfb5HmiqE2raao1O6xW/vZ4lipNeCO
	o6zaEc8iyKCS3ec8A1pgoaCIQuNLJXHrCHHLZADVCfFFn2paOt5hT8FDNTN53cF3bSB1HKBDccN9t
	EmbrSZxnQy1hQotqzi4TnWZNCIxuEtm1zOW4RMKUf0wwZKJpALwOPmw7NsNwwUL1V0ANJJnl4Moqr
	LTce4OBw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVR0-0000000ASYE-3zUa;
	Sun, 04 Jan 2026 21:14:46 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1vcVQw-0000000ASXo-1XLG
	for linux-nvme@lists.infradead.org;
	Sun, 04 Jan 2026 21:14:45 +0000
Received: by mail-wm1-f46.google.com with SMTP id 5b1f17b1804b1-477ba2c1ca2so145726215e9.2
        for <linux-nvme@lists.infradead.org>; Sun, 04 Jan 2026 13:14:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1767561280; x=1768166080;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qNq8Dlg9dgt9AwcFJgT9Gsr/YTM893QKcON0HPwwdp8=;
        b=LhvjNyDQhcbbrKTO5JMQFCJUZjsz8dORX4ucqMQnTc6g4HGw8cfDT88O7R7VXS6UPS
         mK2HPlyQ206g4cjUPbsd7CjYi+8znIjdym7P5wkbpz71tvFRN94gsDFVc7b/9+FWal3J
         DPBsLHBJAmFh6LKZB4DvVUKy4llP2/swSrRNENLvh5IZPZc7rzUtqCpJ86vkdWLppXv6
         BjgtGhSV5sJAP+L9TuqDNrI7+XwcFkW9go23D7V0WZITEzhSD5C71Gg823tgRDsvbofx
         f9VH/PsiHiuzUNYfQOHY2Vqvt4CCGuGyQ4q26KH56geYnuqFfm+cZIhuHwpuVnMjG+y6
         cMpw==
X-Forwarded-Encrypted: i=1; AJvYcCVpqsceqkp3ocOnspH7+cRONRWRlaRdQdWrfmMgAeHego1szLaNlPDlapp4s0024B6IG1ksGUIyNinx@lists.infradead.org
X-Gm-Message-State: AOJu0YxhzTbzA3x0yJAZIiPahZuKQAkIO+oNJ14VccixMoZoH2lv6Ugj
	MYaxj7ysDoCBP+K4ZqRXTfF7emfd6/pKSdBaTAgXNdU543/XsCKMHT+6
X-Gm-Gg: AY/fxX44J1Is7XMSw45YAhVlvmFfQPuvzpRusEAvC2A6BuOCZPxtUJVw7BOq6B23qWf
	2Bi4ncmy1kF1HMrWthiJPadkusRlynPIlGNCAdc/wjxGC3MEjLNgaTKnzogCRt1S4siKz81X3bQ
	aTSjPP+f8BLVyJfPhen5vm7rCgxkEkffZDsGYmnhx6xOWxqxMSxTEN2j42jfpcmkfCrKfpLVT4a
	gAPbbFJRFhhKixU8Sa3Z8nkFK8S1sladBr7hqEzKVMNFuo0iGucpmJWe+vHhvcK/Wdc5WVM5yuu
	AST7tRbbzsnHx2UpvZ3F/k1iSxABehwwwRBgsqOB+tEvZ7oyawTcXqRnHcbBEdo5xsc1e9KSYtU
	1KMW6Q+JA86AfNu/ulRXVFS1pKepEw3f9CXUc+F3U2/gXR3UP1oU6VI0sjyL1qbJroRH5Hc22oW
	m5dWU7Gd6zHa/lwM3SleEJmJyb8ZgUvR33Uf/6d2GIyoI=
X-Google-Smtp-Source: AGHT+IHs2arPN3RkmiegOcVtY/bLcuBg3k5L5UufZRXlnha3S7kV/nLqLCoygpJQqggk7WxemF89FA==
X-Received: by 2002:a05:600c:4e49:b0:471:13dd:bae7 with SMTP id 5b1f17b1804b1-47d195911b8mr534608505e9.30.1767561280324;
        Sun, 04 Jan 2026 13:14:40 -0800 (PST)
Received: from [10.100.102.74] (89-138-76-94.bb.netvision.net.il. [89.138.76.94])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-43277b0efefsm63949382f8f.25.2026.01.04.13.14.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jan 2026 13:14:39 -0800 (PST)
Message-ID: <3fb01be3-e162-42fa-8d75-2e96a89b2004@grimberg.me>
Date: Sun, 4 Jan 2026 23:14:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/14] nvme: Implement cross-controller reset recovery
To: Randy Jennings <randyj@purestorage.com>
Cc: Mohamed Khalfella <mkhalfella@purestorage.com>,
 Chaitanya Kulkarni <kch@nvidia.com>, Christoph Hellwig <hch@lst.de>,
 Jens Axboe <axboe@kernel.dk>, Keith Busch <kbusch@kernel.org>,
 Aaron Dailey <adailey@purestorage.com>, John Meneghini
 <jmeneghi@redhat.com>, Hannes Reinecke <hare@suse.de>,
 linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20251126021250.2583630-1-mkhalfella@purestorage.com>
 <20251126021250.2583630-9-mkhalfella@purestorage.com>
 <c698d201-0099-47a7-b5b0-d2322da63ea0@grimberg.me>
 <CAPpK+O0dmysf6HxQN68q-JzSm-YATXQ1ZUcz-D56-+4WE-Aj7Q@mail.gmail.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAPpK+O0dmysf6HxQN68q-JzSm-YATXQ1ZUcz-D56-+4WE-Aj7Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260104_131442_450102_F4E1BBF8 
X-CRM114-Status: GOOD (  24.06  )
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



On 31/12/2025 2:04, Randy Jennings wrote:
>>> +
>>> +             if (!ret) {
>>> +                     dev_info(ictrl->device, "CCR succeeded using %s\n",
>>> +                              dev_name(sctrl->device));
>>> +                     blk_put_queue(sctrl->admin_q);
>>> +                     nvme_put_ctrl(sctrl);
>>> +                     return 0;
>>> +             }
>>> +
>>> +             /* Try another controller */
>>> +             min_cntlid = sctrl->cntlid + 1;
>> OK, I see why min_cntlid is used. That is very non-intuitive.
>>
>> I'm wandering if it will be simpler to take one-shot at ccr and
>> if it fails fallback to crt. I mean, if the sctrl is alive, and it was
>> unable
>> to reset the ictrl in time, how would another ctrl do a better job here?
> There are many different kinds of failures we are dealing with here
> that result in a dropped connection (association).  It could be a problem
> with the specific link, or it could be that the node of an HA pair in the
> storage array went down.  In the case of a specific link problem, maybe
> only one of the connections is down and any controller would work.
> In the case of the node of an HA pair, roughly half of the connections
> are going down, and there is a race between the controllers which
> are detected down first.  There were some heuristics put into the
> spec about deciding which controller to use, but that is more code
> and a refinement that could come later (and they are still heuristics;
> they may not be helpful).
>
> Because CCR offers a significant win of shortening the recovery time
> substantially, it is worth retrying on the other controllers. This time
> affects when we can start retrying IO.  KATO is in seconds, and
> NVMEoF should have the capability of doing a significant amount of
> IOs in each of those seconds.

But it doesn't actually do I/O, it issues I/O and then wait for it to 
time out.

>
> Besides, the alternative is just to wait.  Might as well be actively trying
> to shorten that wait time.  Besides a small increase in code complexity,
> is there a downside to doing so?

Simplicity is very important when it comes to non-trivial code paths 
like error recovery.

