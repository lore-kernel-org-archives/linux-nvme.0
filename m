Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35959C433FE
	for <linux-nvme@archiver.kernel.org>; Wed, 26 Oct 2022 08:31:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=/wGPh6C7pwPjkSecgvuiwWu7O15KAMPBaLRjMD0pOZ0=; b=fr553ahNZ8O7RBQUt//aLvIAhC
	/zvfR/MeoEMGaFQcTqjUDv/q5Wg6qT+fR+kyHQOw92UPLgBVWE97JY0io8qTQ516+sMoMNBQHROlT
	13LpT/j72NhvFWdnxBmwceHHxAF53UH75RZNnZJ2bHv9iFA8Xu/x3HKi9O7ltwjRmfawQ8i0h6Wdl
	1sJgX95rE0cPe4NtmhE1fla1AlMe8ZKQtI6t7FlYKhKp/EMYt4b7bg9nIGPfvV1+0dARadHMngzXx
	r6D43EqZuY0r8cTOLX/D9ijBvuItribcQgqYB1aYQod5JhS+poFlMwJ+EVibPu1+VTvg4FLHUPfVZ
	2qx0X4rA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onboP-008ZOL-VO; Wed, 26 Oct 2022 08:30:58 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1onboN-008ZNb-Ca
	for linux-nvme@lists.infradead.org; Wed, 26 Oct 2022 08:30:56 +0000
Received: by mail-wm1-f43.google.com with SMTP id l32so9690278wms.2
        for <linux-nvme@lists.infradead.org>; Wed, 26 Oct 2022 01:30:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/wGPh6C7pwPjkSecgvuiwWu7O15KAMPBaLRjMD0pOZ0=;
        b=GM01vZeTz7Ay9Q5Z3y4H8gwWubpLqnOUZp9aqmb3Ro5oRG3vSxt3E1Y1dLELI3x/IK
         91kNK+YeSNvDOR6Yezl8mbyqKdEXIGe4u7lvGk1mQjw9yofPZtMZZWVoHfA7PGzZxA+n
         ZA0wbXmBJ5RaWokkTW0BWndMUV3pKroBio1E6O/qSqvFxrHYLOz1F2pgpD0tZNSAEdoT
         zMCER1gaU8zfjN86DV5CSuFradkWglNYz3nTxwx2ZDCsaHGQLLi59Z1ieM01YSBBZxZy
         PO+8yZPBIuRdZcMVfEfeUtpW8Idj0B6Zr7ozY6vDrcNyA1ndTgIppTxmJXuqSWaMC9zY
         E7lA==
X-Gm-Message-State: ACrzQf1e3B6GwNzNTD09v5dvQxxyc5SnRw3tSG11dBTnfV09gAeWTtRe
	RiJdVKKmru6hCMIEtCOnnx0=
X-Google-Smtp-Source: AMsMyM47o3tu4KpgEyR7/AtACTf+GNNo7phXX/63Vv6faXgoWElzWZqakj6VOwhdtp3OCwjWORRjuQ==
X-Received: by 2002:a05:600c:1d95:b0:3c6:fc59:5ed0 with SMTP id p21-20020a05600c1d9500b003c6fc595ed0mr1476597wms.21.1666773052622;
        Wed, 26 Oct 2022 01:30:52 -0700 (PDT)
Received: from [192.168.64.94] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f5-20020a5d58e5000000b0022e36c1113fsm4859337wrd.13.2022.10.26.01.30.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Oct 2022 01:30:52 -0700 (PDT)
Message-ID: <202cf139-c8d2-5a55-ed83-d975c136cab2@grimberg.me>
Date: Wed, 26 Oct 2022 11:30:50 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2] nvme-tcp: send quota for nvme_tcp_send_all()
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Hannes Reinecke <hare@suse.de>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 Keith Busch <kbusch@kernel.org>
References: <20221024150334.29215-1-dwagner@suse.de>
 <529264d7-c3a6-04dc-f705-c0ce3a49759e@nvidia.com>
 <fb22c7e1-3731-f997-1896-024745082ad7@suse.de>
 <9f40e42d-7525-5644-6773-19e3b842f7f1@grimberg.me>
 <20221026071340.ocqe74c6fvv52sdg@carbon.lan>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221026071340.ocqe74c6fvv52sdg@carbon.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221026_013055_452185_B1913EAB 
X-CRM114-Status: GOOD (  14.03  )
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


>> Daniel, does adding cond_resched() make the system responsive again?
> 
> As it turns out I can't reproduce it anymore. Our test lab got
> restructured and the cabling between machine changed (maybe even
> different network switches, idk). Also the target got a firmware
> update.
> 
> It looks more like the real problem was caused by the network
> infrastructure than the host itself. And adding the additional delay in
> the send path was just reducing the load which made the ssh session
> working.

Let's table it for now.

> Given this, I don't think we currently need to touch this code. Though
> the unbounded loop makes me a bit uneasy.

This flow only enters when there is a single request queued, so it
should not be something that takes long. Unless there is a real
problem, lets not add code that may produce one.

