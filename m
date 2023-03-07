Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 401C2C6FA99
	for <linux-nvme@archiver.kernel.org>; Tue,  7 Mar 2023 22:10:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=l7VwJJVB88UmFcLOMhMHTMnL4TYnG2AxJAZJdexyzG0=; b=I7vMRDlasB18kIFnjjRUMb1oJz
	GbUxf2Wb+n4MVFMinfisjYRIuIxE/7oiKcmZY+EdVeebdwE9PrjDL9/+GBWJqcF20CzZSRcJXzfEv
	F7If99wiz5Yn9ZwpmsV1ArWnpmCR6+Fbalcm0Kyh82zvOqqa6sRcJCUpZC7hBrsOcDd4xyxkzq5dk
	y8IqFAEIk20oj2ICSa2DLBwl0zzEynICVlvR5m9rb7R+9jjbU3nyK4am0w9T0BCRKgthE1AwTqz/3
	cUTF7Bfh1v3te8B3lcr2GlakRvK42e9SM5ers8BbONAG3ubIMTBZvoRQe1le2R4DjhDDCt/VPK/FQ
	F3UWSfpg==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfVY-002aNX-1I; Tue, 07 Mar 2023 22:10:08 +0000
Received: from mail-qt1-x835.google.com ([2607:f8b0:4864:20::835])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pZfVG-002aHR-1K
	for linux-nvme@lists.infradead.org; Tue, 07 Mar 2023 22:09:51 +0000
Received: by mail-qt1-x835.google.com with SMTP id y10so16225794qtj.2
        for <linux-nvme@lists.infradead.org>; Tue, 07 Mar 2023 14:09:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678226988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7VwJJVB88UmFcLOMhMHTMnL4TYnG2AxJAZJdexyzG0=;
        b=OPnRd2T2PNX6MLkA117lS5FihRoXme4wxCUjrI6qY8jocWrmVGhkKP1/EloosAr3Q+
         1voXcGoxXMg3aETur/p3fjGmRVBRzNuGt55OWBVYcEGHGdK9aulANoqgbcdwD/eL6YA3
         YVX9cQyJ08NHwlnRiQwGRVXAoR64wchLJ2aegaS9qO+7c7BkOgXvewtLAymDvmqCesp6
         4/6NXgFC7XHllfFYTUPbhTVaJa/+4Wtf2Qg8GVwILaYP6eiwU+iWHFeVtXmh+6U4nGiE
         o6WwlCY8Kp3aHo154bSFw23FQihwZcpVi6HkeTD7JVsq0MBEmKrkWkrmvt4IdiKuIHTZ
         ZtrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678226988;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7VwJJVB88UmFcLOMhMHTMnL4TYnG2AxJAZJdexyzG0=;
        b=o2LDW9IElCJXN1m2yGJWEuAap5326jFc0faeMffpjFs+CqmgZejuSJDsxrqjFNkTwW
         Ngho63mNh5ZlZErU34AuZwCeGTdxZ/i2Z6SgJjpKzkyc5dHk1Cd7LxfoKcGQBG/zr7zv
         1QzizZtiNIGuop9a6UIpI4HGSL06qhkSjDo1VGcwlkUoMaFb8XDaearnlFwnJS+ojbBX
         ldtHvfJx762VtIebmuFDAt1mdwGU2kfuAJJ4I4NFuqb1KXqbu78nCWdGt26WlbFXx1eC
         riAe3epv7Q/o4MOJMDVszUZMrx5zhtx8VjAipn0uBYhqLr3Ky404KwbiVNViNzJ45LVC
         YfVw==
X-Gm-Message-State: AO0yUKUeTd2kqFWXvb2704JoNzPZZSIfIvuuO3u3Rln4iERh24xz8Z+v
	wuoSgv2B+LFIzquDwI3cWEjy49oMHvY=
X-Google-Smtp-Source: AK7set9UAHuRgRT56zrSDdttyN15yx3lFR/SlMpLzXhVQ5oqkem37mA+CaMcjt045Cx7I1HsO+ywUw==
X-Received: by 2002:a05:622a:44c:b0:3bf:bdb8:c64a with SMTP id o12-20020a05622a044c00b003bfbdb8c64amr28245293qtx.49.1678226988565;
        Tue, 07 Mar 2023 14:09:48 -0800 (PST)
Received: from [10.69.46.142] ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id o26-20020ac8429a000000b003b8484fdfccsm10519252qtl.42.2023.03.07.14.09.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 14:09:48 -0800 (PST)
Message-ID: <fb370f8f-f438-68c3-0f52-9d9c22f278e0@gmail.com>
Date: Tue, 7 Mar 2023 14:09:47 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC v1 0/3] Unifying fabrics drivers
Content-Language: en-US
To: Sagi Grimberg <sagi@grimberg.me>, Daniel Wagner <dwagner@suse.de>
Cc: linux-nvme@lists.infradead.org
References: <20230301082737.10021-1-dwagner@suse.de>
 <a73ea22a-9871-d152-080e-49c0904dbe94@grimberg.me>
 <20230307122849.3oc66ojdsgvvj77h@carbon.lan>
 <442f638a-9ecf-0f17-82e5-06312c2ec5d6@grimberg.me>
From: James Smart <jsmart2021@gmail.com>
In-Reply-To: <442f638a-9ecf-0f17-82e5-06312c2ec5d6@grimberg.me>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230307_140950_116721_966B22CB 
X-CRM114-Status: UNSURE (   8.68  )
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

On 3/7/2023 4:34 AM, Sagi Grimberg wrote:
> 
> I'm not saying that we shouldn't, I'm saying that we should consolidate
> with all transports (rdma/fc/tcp/loop and ideally also pcie which is
> closer to fabrics than what it used to be).
> 

I have this same sentiment.

-- james


