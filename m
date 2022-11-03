Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 473BCC4332F
	for <linux-nvme@archiver.kernel.org>; Thu,  3 Nov 2022 21:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=VEXZ8j2ByvWkoWbhxiTccRPl5r
	I2fDPfRYj1Gc1SgEJGmey8PhevwLxkjsOHxTte7sWFIvwFN1gLLfhEiKjcai/NR2bkTliQfU5y9iF
	joXYnpjIWvCTeo/WHjnCZG48fVHIWj3rBDBnGrmbDw7jJ/VgO99VCeODHvjMYVf57pMjxtqIbE/5C
	SY8TxnOpzuVnjoZlVDvnUzNqCrDkW85DCmymIe3nfVz4m8xsguLnllv3mnHb0wz0au4zAuSydC41Q
	ml9wPGb30uvFVrgN+aYIrUbmHqKDGxxHHsDmc3SH/c1KcRWiLhaK9ExV7e8Ab6Cm2+O62h7Kjfyp7
	lMwuR6ew==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqhfZ-001k0P-V2; Thu, 03 Nov 2022 21:22:37 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1oqhfX-001jzY-Eb
	for linux-nvme@lists.infradead.org; Thu, 03 Nov 2022 21:22:36 +0000
Received: by mail-wr1-f46.google.com with SMTP id w14so4570514wru.8
        for <linux-nvme@lists.infradead.org>; Thu, 03 Nov 2022 14:22:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oEtXSPvT85VcWMxvYRq4gx2RAZMIqweaxq8ZJzQac8U8HmaOcVawzBKog8Yz7qL5Os
         xLRW0HZIxoEwLf7qzB/FXrSBPJgqZr5nnFEUTu1IA1byJowG08wkwc9H6Dwfvaf0E7Ol
         nH1M4pr9ty4t/im2ryUD9/gdejKrFojAlYtyooHUaXUIhypq41wu3WpDGetxz1D5PTcz
         e/FMwzoQCG1sAovAeYdNdkgJGm4p0oW4agoaqDWiFdHiEocZUn6gI1wJPuY3fakR7nLN
         UYI5U/UFB+EAWLy7s+x1nMK0x1zYQHUboTyYWyKkLdortXw7qwT0Lix8dg5nWtYzGoRS
         s28A==
X-Gm-Message-State: ACrzQf13NTzbfaqL25PGsyRvAVjHcHBf+SuaQoJrqtjz5lKbA6DJ/FHw
	wwEfExwOFD6pYZrNaD7nx0ehhooIxC8=
X-Google-Smtp-Source: AMsMyM6vbgDg2T7zfYdN4Utblj+sLSEY6XjXjSZKMhqBNJwkvQt3LkZmrmluRB/B5YH777ofxe/10w==
X-Received: by 2002:a05:6000:2c1:b0:236:d474:f053 with SMTP id o1-20020a05600002c100b00236d474f053mr13879235wry.517.1667510552800;
        Thu, 03 Nov 2022 14:22:32 -0700 (PDT)
Received: from [10.100.102.14] (46-116-236-159.bb.netvision.net.il. [46.116.236.159])
        by smtp.gmail.com with ESMTPSA id w8-20020adfd4c8000000b0023672104c24sm1750655wrk.74.2022.11.03.14.22.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 14:22:32 -0700 (PDT)
Message-ID: <38001177-5557-6898-7e66-06223ffd7715@grimberg.me>
Date: Thu, 3 Nov 2022 23:22:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 6/6] nvme-auth: use a define for chap buffer size
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <20221102075224.70869-1-hare@suse.de>
 <20221102075224.70869-7-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221102075224.70869-7-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221103_142235_518614_2D19C956 
X-CRM114-Status: UNSURE (   6.78  )
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

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>

