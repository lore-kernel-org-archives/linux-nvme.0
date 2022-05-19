Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 162C8C433FE
	for <linux-nvme@archiver.kernel.org>; Thu, 19 May 2022 03:41:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:Subject:From:References:Cc:To:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=E+Jeeum5dAYeu7JrVKgmUScX8K6q6nSaD3V1Uo7Z0xo=; b=YAKGHnVKZoedl5RIymdFQzd9iX
	X8ufiMKPqS/1T58SWE2UKkI+X8QGGdedizkypAY2u+2w9sjD5Nk84qdeuGKNsjIrC7JPqpY+LrwUw
	tTYrbE2w05JbIJOrObWhJi2tGVK2iKTAhRGeY/TSFM7qEy9CoGbUlWQAx9tSCo1iFG9zSBhIeg2BL
	HR8gfRJ/3Y6GV6uTUtKW4PcSjV5o9o8+Qx48hC8Z/xKTCL3OUvOW8loh5/j3mV27CYh3wBbb6iBbO
	wQwYV/ycOp3i//lzEl9fAyVOYSJPdDZdRljYHI+cd9WA6ngG0OU775O/iedoOJRJlpCcQ6EDzoaUl
	JqmASIbA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1nrX2e-004tjF-Gb; Thu, 19 May 2022 03:41:36 +0000
Received: from mail-oi1-x233.google.com ([2607:f8b0:4864:20::233])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1nrX2b-004ti3-Eu
 for linux-nvme@lists.infradead.org; Thu, 19 May 2022 03:41:34 +0000
Received: by mail-oi1-x233.google.com with SMTP id w127so1631706oie.1
 for <linux-nvme@lists.infradead.org>; Wed, 18 May 2022 20:41:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20210112;
 h=sender:message-id:date:mime-version:user-agent:content-language:to
 :cc:references:from:subject:in-reply-to:content-transfer-encoding;
 bh=E+Jeeum5dAYeu7JrVKgmUScX8K6q6nSaD3V1Uo7Z0xo=;
 b=KFjvSCT6GXj5Kr0HO4phTFW0x5Mhrxpol/LwndM9mgk+gt2L/LZ/5khjHvxx9tCYCl
 ccDkePOGAv4JpJmRo0Xqzh6ClQpZnN/1/b7sQl4OHAEBLezdGI2XWE9/o/Z1OZFdJplA
 hvInyanC3HKTFBbmtIho+sxxjhNvtMvXN/SpDUcK6pzwbtXhkX4B8r6bM063uhwPRf2Y
 cRgCWW0s7tOlAD3+MsxhCIYV0WDd/vE6gTqXbb2/O3YdWrgPTUK3f0QWoOCgnNy5j+zJ
 Pm+2UwK0eLGDknVSYV48h5O6crlLJ0idezAZuMW3TB+ty1IBtVt29pHwTXbVrYvZnNon
 S1IA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:sender:message-id:date:mime-version:user-agent
 :content-language:to:cc:references:from:subject:in-reply-to
 :content-transfer-encoding;
 bh=E+Jeeum5dAYeu7JrVKgmUScX8K6q6nSaD3V1Uo7Z0xo=;
 b=zyTHvNxVJfBIs7wMrTzpWRQ7Y+T7d8mESD9q7Q26Lmmzsry96TXaZLCFe1Fs5WXH8l
 URF6vyguJLFZ+jPuPGpjEWsOwYBpGXwK9r5IianeV+pbqqijqTHxl8Qg4sTPfXOUWkf1
 4rWsBFblcmG0md5ZOe6mmB5s/ciZappvpOvq+mfUDJrso+RL6rQ1VN0oKJnzJGDgaC9H
 1Bqv1UBMKc9arIewoqQiSBXMjoBSwVKOiR14NLv6OxxHgxDJl2cBZfugz8Nyf7iimIBJ
 RIEYWmcP2NLYGujhA5rFY1k4sGgTPBtLANkypFzh+vHl69mvnIK6qSu1UssmcJDOC5g8
 4tSA==
X-Gm-Message-State: AOAM532OTB1faoB5BDKzdQPRspCW9caROOWsiquWucemxcTOo6f5OdYq
 Q+0rTgdI0nmItjSxte2V2c4=
X-Google-Smtp-Source: ABdhPJzNbyvmXREi3jFpQ1BXha9I4ZZcQvTagfhdtbiKBgx1gr2M0BpSR/Ospfm2JXh/HEBEZ+zfpQ==
X-Received: by 2002:aca:4154:0:b0:322:7a9c:7daa with SMTP id
 o81-20020aca4154000000b003227a9c7daamr1784072oia.52.1652931691271; 
 Wed, 18 May 2022 20:41:31 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c?
 ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
 by smtp.gmail.com with ESMTPSA id
 p4-20020aca4204000000b0032694a9925esm1451284oia.10.2022.05.18.20.41.28
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 18 May 2022 20:41:30 -0700 (PDT)
Message-ID: <0530d502-1291-23f3-64ac-97bd38a26bd4@roeck-us.net>
Date: Wed, 18 May 2022 20:41:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Content-Language: en-US
To: kernel test robot <lkp@intel.com>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: linux-staging@lists.linux.dev, linux-omap@vger.kernel.org,
 linux-nvme@lists.infradead.org, linux-hwmon@vger.kernel.org,
 linux-fbdev@vger.kernel.org, kvm@vger.kernel.org,
 dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 Linux Memory Management List <linux-mm@kvack.org>
References: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
From: Guenter Roeck <linux@roeck-us.net>
Subject: Re: [linux-next:master] BUILD REGRESSION
 736ee37e2e8eed7fe48d0a37ee5a709514d478b3
In-Reply-To: <6285958d.+Z2aDZ4O1Y9eiazd%lkp@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220518_204133_572592_424AB7BA 
X-CRM114-Status: GOOD (  11.30  )
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

On 5/18/22 17:55, kernel test robot wrote:
> tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git master
> branch HEAD: 736ee37e2e8eed7fe48d0a37ee5a709514d478b3  Add linux-next specific files for 20220518
> 
> Error/Warning reports:
> 
> https://lore.kernel.org/linux-mm/202204291924.vTGZmerI-lkp@intel.com
> https://lore.kernel.org/linux-mm/202205041248.WgCwPcEV-lkp@intel.com
> https://lore.kernel.org/linux-mm/202205122113.uLKzd3SZ-lkp@intel.com
> https://lore.kernel.org/linux-mm/202205172344.3GFeaum1-lkp@intel.com
> https://lore.kernel.org/linux-mm/202205190527.o9wVEvHI-lkp@intel.com
> 
> Error/Warning: (recently discovered and may have been fixed)
> 
[ .. ]
> drivers/hwmon/nct6775-platform.c:199:9: sparse:    unsigned char
> drivers/hwmon/nct6775-platform.c:199:9: sparse:    void

This is getting tiresome. Every driver using outb() on m68k will
experience that "problem". As far as I can see, it is caused by

#define out_8(addr,b) (void)((*(__force volatile u8 *) (unsigned long)(addr)) = (b))

in arch/m68k/include/asm/raw_io.h. I have no idea what the
"(void)" is for, but removing it "fixes" the problem.
Either case, this is not a problem with the nct6775 driver,
nor is it a new problem.

Guenter

