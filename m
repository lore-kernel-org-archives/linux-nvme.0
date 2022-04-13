Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F24F1C433F5
	for <linux-nvme@archiver.kernel.org>; Wed, 13 Apr 2022 05:53:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7hPk+CDiUhT3JD/4KlOy9PmYny5BxqkX8wQhMDLl178=; b=BJgJ3NifxOXn0I9LirckJCAd54
	gNr51RG1aqERaFdPUqb6U07XMaKh7vMuQdfFN3HsJjVmGuKtPTMJLN/cubCH3l43LzbbPMM50wxYR
	njazBbZ4eYmTBqNRIVLFns1hDP05D423IrpUjA99uypv6RwwDLT/GAVIbo1htCQoinrxL0fKtosOi
	qoqvloEaiO8Qiu0qePRW0vDzQ6CnudKSLWRUZ6RiszfG7XO9d37mEYWQE7unHJEuzG638wcNialrC
	1n4HXWP+/PE3D/YgbjpBmGBpDeOFDQBoEL7gkj3DM515F60EzwFNidNZ4R/13jgpIWKU32raU/ezO
	YQ4iQZjA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1neVwt-00Guof-2I; Wed, 13 Apr 2022 05:53:51 +0000
Received: from mail-pf1-f180.google.com ([209.85.210.180])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1neVwl-00GumZ-MT
 for linux-nvme@lists.infradead.org; Wed, 13 Apr 2022 05:53:44 +0000
Received: by mail-pf1-f180.google.com with SMTP id b15so1081343pfm.5
 for <linux-nvme@lists.infradead.org>; Tue, 12 Apr 2022 22:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=7hPk+CDiUhT3JD/4KlOy9PmYny5BxqkX8wQhMDLl178=;
 b=NCJ4kLcms5gj+uamF5JYgfloSb/UJVsdMdqsU35+BdM7AfYvuXC5gBuCPlLZ3XQKJT
 HTiUHMXd8A6p3P1+VD9EZACVfQmuQl8f5DJaczGaw1vs9GHnElWnc9CEuTAEbmfdnLZz
 9lnCDzs40nhTOEoEkEZXenvnAYx1ISKoR3VMv0m5QplKpMQlCMV7r0gLCESBTwLMUht8
 21EsDcPbQBZT2G1bDkpXbDvQf4bECOJams8oKzEshNE5wB5EknqKn1XJVRvxGcH6bNtN
 tdzqcf08+9m4zUymJrpEn0UF+mXkyP8u0N6MBuDJnqHoSQ02sLLjgcyKi945QoHLwvRw
 l1vw==
X-Gm-Message-State: AOAM530Z4OsXz7T4mBz7OPUnll8s1KX1NGROOz8BgB6Ri24A2wZfBfpo
 MLdZRFJpevoYe2ZEgN/WOok=
X-Google-Smtp-Source: ABdhPJwRT23HPoexC5yYGQPBB/VJ963HigzBKo7vq4W80KNN5BrXnKQs3HXqgXZSgsedU8Razo9WHA==
X-Received: by 2002:a05:6a00:17a4:b0:505:b651:5b98 with SMTP id
 s36-20020a056a0017a400b00505b6515b98mr15684803pfg.25.1649829221945; 
 Tue, 12 Apr 2022 22:53:41 -0700 (PDT)
Received: from ?IPV6:2601:647:4000:d7:feaa:14ff:fe9d:6dbd?
 ([2601:647:4000:d7:feaa:14ff:fe9d:6dbd])
 by smtp.gmail.com with ESMTPSA id
 o32-20020a635d60000000b0039cd48c7f6asm4666994pgm.32.2022.04.12.22.53.40
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Tue, 12 Apr 2022 22:53:41 -0700 (PDT)
Message-ID: <6cd7ebd1-f069-7f95-62f5-e8b18d6b3e58@acm.org>
Date: Tue, 12 Apr 2022 22:53:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: can't run nvme-mp blktests
Content-Language: en-US
To: Luis Chamberlain <mcgrof@kernel.org>, yi.zhang@redhat.com, sagi@grimberg.me
Cc: linux-block@vger.kernel.org, linux-nvme@lists.infradead.org
References: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
From: Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <YlYYJC/WUEsnI9Im@bombadil.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220412_225343_784775_104F25BE 
X-CRM114-Status: UNSURE (   9.96  )
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

On 4/12/22 17:24, Luis Chamberlain wrote:
> I do have CONFIG_NVME_MULTIPATH=y but I also have:
> 
> cat /etc/modprobe.d/nvme.conf
> options nvme_core multipath=N
> 
> And yet I always end up booting with:
> 
> cat /sys/module/nvme_core/parameters/multipath
> Y

Is the nvme_core module loaded from the initial ramdisk or from 
/lib/modules? In the former case, does the initial ramdisk perhaps have 
to be regenerated?

Thanks,

Bart.

