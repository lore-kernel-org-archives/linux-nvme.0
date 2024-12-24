Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11D92E7718D
	for <linux-nvme@archiver.kernel.org>; Tue, 24 Dec 2024 11:18:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=; b=xdQTBth7b9TPR77cVqwVN2idv3
	4xGSg0R2xeUWgWbC+b0xUdF+/KvsMTlHCvfVCByaN8X+4g1DvUNCauZonzFcJjkQqJIkbXGy3O4Bi
	ijfwTH++BZqT75Swyl8uMmv2ms/dMcZH1D+ehMPCtsgFIyf5NSP8RHg8E5rxC1qptfwlSGM732uQN
	uhncsgsTPRoERZUmc5gVBsR378ZUQkCXCD/zvMVexPJiHE65eLf1ftlIJnjI0UW8SMH+LkQwjC7py
	MzekcdRi/2UI3Y7syXql00WN6q79Tkv3KZEJc6IFYaZo1WqTPHwCo5vKgEklAzVMEcVLrrasExB+p
	gqE7DBGA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2vq-0000000BqXB-2m0m;
	Tue, 24 Dec 2024 11:18:34 +0000
Received: from mail-wr1-f46.google.com ([209.85.221.46])
	by bombadil.infradead.org with esmtps (Exim 4.98 #2 (Red Hat Linux))
	id 1tQ2vo-0000000BqWA-3Cgt
	for linux-nvme@lists.infradead.org;
	Tue, 24 Dec 2024 11:18:33 +0000
Received: by mail-wr1-f46.google.com with SMTP id ffacd0b85a97d-385eed29d17so2465886f8f.0
        for <linux-nvme@lists.infradead.org>; Tue, 24 Dec 2024 03:18:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1735039111; x=1735643911;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=oRWLCVginG3BS0GvU5rUJHN3GdmsInAt6VsQu/+qOPdwYKkRAQp6SeO6ooqImp4MCX
         RxQB5qfQj3YSZygFUvbXCsIwrqj6Q2RFNDjAnq7w3maX+OhR8iZ+vvNurYTfZrCDw5nG
         318jiHjchbZ9wpnNCEvsgM7DM5HuGnEukfqGTgCLbio/8rLl82/nLwUt0syYmAF+GmcD
         qoK7poeRpyB14IE+YIBoiW7upsLWK0rgUmori0De554PGDWi1mtdv+DwqsABBME+dQxV
         C5NSYMR72nkFeX8rGtHbAj1AB1ATfOEfj1/rpm4XrHSttqVB6Ez4gHjEY/5wvicWWD+f
         +FCg==
X-Forwarded-Encrypted: i=1; AJvYcCX2T1K8Rosi/lwtbjNswYyYui9Zck40Lfxxqhwl98ncMpyPrvO51vP3D0kEDnaTC0xtKwTYN2j6x17F@lists.infradead.org
X-Gm-Message-State: AOJu0YyGWbGbF1xOeEMhpo3LKYkGtatHRpKcMnTS7+uigix1MkwksU2u
	dGbDdqnu5WqpsRzoCgp4lrhG8TfgdWyGaPW5Hkrfecrwa1AWiBEL
X-Gm-Gg: ASbGncte3LTSKPKblq+xdCUm62m2Rmq5zUdfrlU3gVTJ8PcX/UWHCpXiBdamYUzqECR
	klyG9fHRpDDU2ODjtA1NiGwD/KnkYK7JVj2leqDVmJ280zq6LX1kCqi/c8sauxzogd4obKA0DUR
	j9gOfSvONVS2tZmlNJO4Hrlfo8klJz+ltZgtgDxPmM1nrpzRkjauwo10LMtvF62lrxlH6ldlyfk
	nJFxtXmmnRewUOKWavyU4BH1suMU5yECq8gIIStYD21fj5fbKdvTcLqIYZmE40xoemBDZatOZGj
	QyDNixHlgLW/wpokRgyakN8=
X-Google-Smtp-Source: AGHT+IE+Z9A8wZxKps/mX2N2SykYlghxMfdxTzyXebOw6fDqzWpXXT8+C0rhptdHEDwF3fLM2h9RsQ==
X-Received: by 2002:a05:6000:178b:b0:385:f4b0:596 with SMTP id ffacd0b85a97d-38a221ea824mr14106423f8f.18.1735039111058;
        Tue, 24 Dec 2024 03:18:31 -0800 (PST)
Received: from [10.50.4.206] (bzq-84-110-32-226.static-ip.bezeqint.net. [84.110.32.226])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-38a1c8472casm14184974f8f.45.2024.12.24.03.18.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Dec 2024 03:18:30 -0800 (PST)
Message-ID: <4f907afe-4508-4836-8c76-523ae505be76@grimberg.me>
Date: Tue, 24 Dec 2024 13:18:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCHv6 RFC 3/3] nvme-multipath: Add visibility for queue-depth
 io-policy
To: Nilay Shroff <nilay@linux.ibm.com>, dwagner@suse.de, hare@suse.de
Cc: kbusch@kernel.org, hch@lst.de, axboe@fb.com, gjoyce@linux.ibm.com,
 linux-nvme@lists.infradead.org
References: <20241213041908.1381196-1-nilay@linux.ibm.com>
 <20241213041908.1381196-4-nilay@linux.ibm.com>
Content-Language: en-US
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20241213041908.1381196-4-nilay@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20241224_031832_805414_723368F2 
X-CRM114-Status: UNSURE (   4.04  )
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

