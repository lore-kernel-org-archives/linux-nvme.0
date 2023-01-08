Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B95E1C53210
	for <linux-nvme@archiver.kernel.org>; Sun,  8 Jan 2023 15:30:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=UfeayS01aKY9ZA6GxR86XiRT3Ffvetp5BhLvbMKyo5Q=; b=ayHwmgmIidYvcs7/FvZ2spsUXT
	bhvehaAsSvoxpo01gnw7R2eNaz6WFyFr3Z0Z5mJr8/EGDTi26wlqQhDiKdW5avvPXgoxw9J2HEEBw
	qEK5rbQ1RG8EbEzfKSkaxTsjjTEaPO0Z9gWRWP85y48f85KoAAd72s5C3uJKGUSF9ayBsMXwksCTd
	Q9gXsZfrz8aaGaOaivMQHInQfcw/U+e2p3lvD2VQGHU0XvZitQHPC41Jv6QTsl6uHnL6WAG9B1S5j
	VAYJcN4mxvZ8uFPNJ6OYdfXsG7Mv9fAmWJDOLceSpec8+HrQGO3gcgQzzFKTM9cUqlOhZ5euo/VG+
	ktEyXKzA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEXck-00EB7v-55; Sun, 08 Jan 2023 15:30:14 +0000
Received: from mail-ej1-f52.google.com ([209.85.218.52])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pEXcb-00EB6o-S8
	for linux-nvme@lists.infradead.org; Sun, 08 Jan 2023 15:30:07 +0000
Received: by mail-ej1-f52.google.com with SMTP id u19so14299250ejm.8
        for <linux-nvme@lists.infradead.org>; Sun, 08 Jan 2023 07:30:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UfeayS01aKY9ZA6GxR86XiRT3Ffvetp5BhLvbMKyo5Q=;
        b=UcJfPDNQGOThc5SSLRZsFzdwR2a8AyZwwOHoEIODVQHg2oV2CyErnjbRVkcBYPLe+w
         Qkd1zfiFInixrMNERtDOx4eZF0Zuc2rWUlR7Q9fnZ39xxAfOyOYpllPOmhkcf95aDCXy
         oNOSLqX5s1/34UqTqgvNpOHQDht4wQE8f6DIdFKp8XJTzNOLNfT2EumZOT73mZ1QsQ0+
         zBG1hB48c2yTYrhbRxpnSTphgwXrFHAPIiSWUAwN6pUBKaD+/zGsxJ2GjU3WT7JY2sHr
         kGabgHZ45n+fjBrNy8ASJsDLB/pU93qhC7vZyRioWazlsnImyDJSqFgn4nqj5ThAqedf
         mJNQ==
X-Gm-Message-State: AFqh2kqQJMQKfD21JTI8ORwHVjg3Vr8Go9g8pyQzi/yFc7kic0DJLiWt
	8ctOo/q5RUaJLGPC0E807WA=
X-Google-Smtp-Source: AMrXdXu+lnmZKAc2ntzxKXjH5kBGScmFKixf/ZbqexPDOOD6nw4OTSlxrRNLNMuIM9fPbd/7nvTlvQ==
X-Received: by 2002:a17:906:850c:b0:7c0:f44d:984 with SMTP id i12-20020a170906850c00b007c0f44d0984mr70462005ejx.74.1673191802847;
        Sun, 08 Jan 2023 07:30:02 -0800 (PST)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id g11-20020a170906538b00b007c16e083b01sm2595130ejo.9.2023.01.08.07.30.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 08 Jan 2023 07:30:02 -0800 (PST)
Message-ID: <ee184cf2-991a-1f78-9adf-c56cdd610e01@grimberg.me>
Date: Sun, 8 Jan 2023 17:30:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: nvmet_check_data_len() wrong behavior for nvme admin set features
 cmd
To: "Engel, Amit" <Amit.Engel@Dell.com>
Cc: "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>,
 "Grupi, Elad" <Elad.Grupi@dell.com>, "Zinger, Eldad" <Eldad.Zinger@dell.com>
References: <CO1PR19MB48850262EAB600869034D420EEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
 <b8154d21-d009-1077-e07d-980b249a56c3@grimberg.me>
 <CO1PR19MB4885EF6A9AE5135487F853BAEEF49@CO1PR19MB4885.namprd19.prod.outlook.com>
 <CO1PR19MB4885CDE3B335B9EAC0B7192DEEF59@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB4885CDE3B335B9EAC0B7192DEEF59@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230108_073005_926547_9BF7DE2D 
X-CRM114-Status: UNSURE (   7.05  )
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


> By the way, why not always call nvmet_check_data_len_lte() ?
> 
> Don’t we agree that the host is allowed to send sgl describing a buffer that is larger than the payload for any nvme io/admin cmd ?
> (and not only for dsm / set_features cmd)

I think we're better off with a tighter check, to avoid possible bugs.

