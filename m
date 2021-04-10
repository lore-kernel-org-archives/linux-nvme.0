Return-Path: <SRS0=Ubpo=JH=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
	DKIM_SIGNED,DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,MAILING_LIST_MULTI,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B782C433B4
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 14:27:37 +0000 (UTC)
Received: from desiato.infradead.org (desiato.infradead.org [90.155.92.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 95EA16115B
	for <linux-nvme@archiver.kernel.org>; Sat, 10 Apr 2021 14:27:36 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 95EA16115B
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=desiato.20200630; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:Cc:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=+9HLr8LOmwCspFHIBPdY6XBDMd+jyhp3YiYBH64Zdbw=; b=Xyh5uoo66s3eQOtOoStGw70if
	TOHv3amlX0foN1YVW1GiXCEcRZ/r0YAkQwp9lx8bi1W0J0EMxvJgfTRlz9GqFI4dLXIiRwNKhkYwZ
	r2afaAv0r3Ns6xeiAOQ2P4FhsZYxmU7qPHEZzpJ92uBeOVXHPWMPI+qLRMGUL6XHjyOOcFFko0ypY
	i12ma9OMYNeV1yQgCLfbyGFSK69M6CVVZ5m1opeeGUG/GZT6bNL5BwEs2IFQRNAeGJ5rATYCkQ+Cp
	D/XN18F+epm20WEBs8QPfiJZunkYhMbfGe7frCAVKAL25f8covW9+SCQIE15x+5NaMCSE7yf6OXiw
	51BXYOtJw==;
Received: from localhost ([::1] helo=desiato.infradead.org)
	by desiato.infradead.org with esmtp (Exim 4.94 #2 (Red Hat Linux))
	id 1lVEZx-002xmB-P1; Sat, 10 Apr 2021 14:27:17 +0000
Received: from bombadil.infradead.org ([2607:7c80:54:e::133])
 by desiato.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVEZp-002xm5-9X
 for linux-nvme@desiato.infradead.org; Sat, 10 Apr 2021 14:27:09 +0000
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
 Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
 Subject:Sender:Reply-To:Content-ID:Content-Description;
 bh=qKJMsDZZnqHO0bohhfsTg2xw0/nercJYI2dO/hMjK+8=; b=cXn54jcazNgNUZQ4STpf6i48+i
 hg/ikHqycceNtBq+UYW+PdpMMLrOI0/iS9YwQDAhoM/uBWoS0mRe9+1L0xBofpw2HNTldzUtwn/Uy
 wyMyB42rbXot62PUBjAUcc1Rol9lkqy7ot9n4hP0H4fx6hxwLcYcVGYNf8Uhk0n77B7I0LshGjDkB
 a06Nb/TYYZBrpKZ6/j/OG1GR1KQO3AUsfvgBU7xaJILvYGyc0p/IWX2ksl5p32uu/pIXyI3pqAbtB
 AkTC1smY3qWubbeEu84mJCfwtOn9CUBbNQHynZ79e90Du4FdG2HeMb+92/1GLVKVX05ro0/mjg1IH
 ZBXy3JjQ==;
Received: from mail-pf1-x433.google.com ([2607:f8b0:4864:20::433])
 by bombadil.infradead.org with esmtps (Exim 4.94 #2 (Red Hat Linux))
 id 1lVEZm-00592q-K0
 for linux-nvme@lists.infradead.org; Sat, 10 Apr 2021 14:27:07 +0000
Received: by mail-pf1-x433.google.com with SMTP id w8so2690728pfn.9
 for <linux-nvme@lists.infradead.org>; Sat, 10 Apr 2021 07:27:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=subject:to:cc:references:from:message-id:date:user-agent
 :mime-version:in-reply-to:content-language:content-transfer-encoding;
 bh=qKJMsDZZnqHO0bohhfsTg2xw0/nercJYI2dO/hMjK+8=;
 b=AqBzbbRQp5D8uyQcaB9xxyfw7b4qipN/XPKI0rndb0OHToPFKN1ANh+ldhBFX1UeoO
 L+joH03dqTD5sFhNsA6NhlKE4j0etuqA12w2HnwBCnc9vYkIDpiFdoFhldcApsgPcS6t
 KJU3yOBaq3zPrT6pOE+LgX17QtML8eqGeHOtSO04ieauVyjSSzV+jrfk+C+Te+qQrjMF
 Jmc4SMjI9XOC5o1HP0cflRqos/9GZmeFNLJqDtNwgQ5bsKeFOhbxRUUNNTQ4EBGoiux5
 AKD3Y92NTXXfd+o6TyA5F0jH8w/tBgUTNsqFuU5KCLiqcAGFEscZgf0NbbZ1HBLgShgv
 qmMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=qKJMsDZZnqHO0bohhfsTg2xw0/nercJYI2dO/hMjK+8=;
 b=faiFkoFJJLBbtSlySFeoChIvK2LjhLqqRSxrJZpWL7l6tTMrkyXEjauPCk7rWOwK3g
 wz8kfkyr/cEzxp8fjwubcfZjCojBnubtDz9QhHSlHv+FCSiq5QrRKqD0w4dVAMTR7bIO
 qsH/xS1SWgqX4sMbr7Y6fnjJnjxGJifs2l8rO3e10Q8jObD3zFBSabDrMg1GUdPbWKHy
 ziAOocbZTF7cxhq5CIQCYqw0XEvsm9U5OhOY7xK2dceKVakSgOjLrxHFaRJrBaezfaCk
 dbOKSX3o4v1MRWVNKlXDBIvFQRZldr5u83uLMRgBPGIcIUipPMRuUV0DQDc19SGbZXab
 Ignw==
X-Gm-Message-State: AOAM533NiwzKLRaiG4PiOkKYcNkFS506x6ox703fdhatwJAc1GDebZzd
 WTkGblwIy6LpiTYavfTPn/o=
X-Google-Smtp-Source: ABdhPJxfHEIb+wq1Fk+9CteyJa5bOlbWtnT9vOS4htlZOzNhogNwRk+3VnQepQglIf4jc/QqBWSDTg==
X-Received: by 2002:a62:6481:0:b029:249:ecee:a05d with SMTP id
 y123-20020a6264810000b0290249eceea05dmr1870714pfb.9.1618064825408; 
 Sat, 10 Apr 2021 07:27:05 -0700 (PDT)
Received: from [10.230.185.151] ([192.19.223.252])
 by smtp.gmail.com with ESMTPSA id x33sm5007908pfu.71.2021.04.10.07.27.04
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sat, 10 Apr 2021 07:27:05 -0700 (PDT)
Subject: Re: [PATCH] nvmet-fc: simplify nvmet_fc_alloc_hostport
To: Christoph Hellwig <hch@infradead.org>, amit.engel@dell.com
Cc: linux-nvme@lists.infradead.org, james.smart@broadcom.com,
 Chaitanya.Kulkarni@wdc.com
References: <20210322195717.13094-1-amit.engel@dell.com>
 <20210410064556.GB335861@infradead.org>
From: James Smart <jsmart2021@gmail.com>
Message-ID: <22529f8d-dcba-e7c5-e6da-d1430134d770@gmail.com>
Date: Sat, 10 Apr 2021 07:27:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.8.0
MIME-Version: 1.0
In-Reply-To: <20210410064556.GB335861@infradead.org>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20210410_072706_703127_4DC97D45 
X-CRM114-Status: GOOD (  11.37  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org

On 4/9/2021 11:45 PM, Christoph Hellwig wrote:
> On Mon, Mar 22, 2021 at 09:57:17PM +0200, amit.engel@dell.com wrote:
>> From: Amit Engel <amit.engel@dell.com>
>>
>> Once a host is already created,
>> avoid allocate additional hostports that will be thrown away.
>> add an helper function to handle host search.
>>
>> Reviewed-by: Himanshu Madhani <himanshu.madhani@oracle.com>
>> Signed-off-by: James Smart <jsmart2021@gmail.com>
> 
> Is this really a signoff from James or a review?
> 

I reworked some of it - so it's a joint Signed-off-by w/ Amit.

-- james


_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
