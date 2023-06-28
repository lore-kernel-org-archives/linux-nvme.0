Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48657EB64D7
	for <linux-nvme@archiver.kernel.org>; Wed, 28 Jun 2023 06:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=llewhcCw1fZpqsM1XkiLEtifsi3NiIC5iPdwF149TWY=; b=dWr+CW3fkDxG8IQRM00b74VCdv
	u7NoHjIbxUIk8hzuGnsgorjT9Y+xTZZ+89hrBpZF0z0iEIP5OoXRHCS0xIf/2pNaQHFfCL9TN2Qth
	PRUfZDYI1GX4S584tb6ggBjTRJmltjglG6PpH1+ZnyMQjKKJ/+eDincooRcLWAQKDHLiEP90xL0qe
	CYpjJfGJOgti4BVAtb33OxOUAscpsm4v2QBkDlQbz5ydM/17MeemC0zLp5zn47HDnOKXd8UmxNon9
	AOef8iBEJ5N0vFzUjJJVxwB+HSfU+Or9ctzHpZsJmHAzEmnTnOwRfpqYZ0QT/8I2TZxaM/tuu/+L5
	3OwL3cdw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qEOxE-00Ez41-14;
	Wed, 28 Jun 2023 06:47:04 +0000
Received: from mail-lf1-f42.google.com ([209.85.167.42])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qEOxC-00Ez29-2N
	for linux-nvme@lists.infradead.org;
	Wed, 28 Jun 2023 06:47:03 +0000
Received: by mail-lf1-f42.google.com with SMTP id 2adb3069b0e04-4f8680d8bf2so1220942e87.1
        for <linux-nvme@lists.infradead.org>; Tue, 27 Jun 2023 23:46:55 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687934814; x=1690526814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=llewhcCw1fZpqsM1XkiLEtifsi3NiIC5iPdwF149TWY=;
        b=KSEjGILXhuQcLleHJrOwAFIhRwVbhtDFnOtEPxL9ieB6t8PVI5lGco5zPNged781rH
         ozGygjYiIVwIywLji95n+PDPBDQpgBJIPJYWgWSbv9OvQzuk6EznPi7igDL2zwmVyLmW
         IyaHFUSKZ9wUhct0/UCsNklPSDwIUjhHv6rydro1h7lEVAXHoDarWh74yDex6LdL3Rbd
         gkfh/nbLgzs2/4oXZRHG9cQnG5+mz9HPIBirrwr5IGullC2JsbWn0WAJOoxBdwKQUmdH
         DKeGb6XWF1ZZjB0oNd3JsZOk0AQ2+1OTLPzhZrqYPaubuGF1TGDxjxsRww9p9yd1yYW7
         QEIw==
X-Gm-Message-State: AC+VfDzCcx5tQPmNyBnt83FsBzwkmtJ6dUViA4xIU7j2MPUdCguWcUpe
	lZ3ZmOX4ofbjgdqib0e/f1myE41Gm+E=
X-Google-Smtp-Source: ACHHUZ6vt52UNX0JVWreukdXEYWnjtFEifQC7U+lp1BtAOwBCfHoLlkuQq++v+xSyHeI/U82bqHOVg==
X-Received: by 2002:ac2:4543:0:b0:4f9:5ffe:87f5 with SMTP id j3-20020ac24543000000b004f95ffe87f5mr9684309lfm.0.1687934813673;
        Tue, 27 Jun 2023 23:46:53 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id f7-20020a1c6a07000000b003fb5e3710d3sm4874498wmc.43.2023.06.27.23.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Jun 2023 23:46:53 -0700 (PDT)
Message-ID: <52df24f1-ebb7-cd24-3aaf-7b946acab3ee@grimberg.me>
Date: Wed, 28 Jun 2023 09:46:51 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [bug report] most of blktests nvme/ failed on the latest linux
 tree
Content-Language: en-US
To: Yi Zhang <yi.zhang@redhat.com>, Chaitanya Kulkarni
 <chaitanyak@nvidia.com>, Max Gurtovoy <mgurtovoy@nvidia.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 linux-block <linux-block@vger.kernel.org>
References: <CAHj4cs_qUWzetD0203EKbBLNv3KF=qgTLsWLeHN3PY7UE6mzmw@mail.gmail.com>
 <4b8c1d77-b434-5970-fb1f-8a4059966095@grimberg.me>
 <8a15d10e-f94b-54b7-b080-1887d9c0bdac@nvidia.com>
 <0c4b16a5-17da-02d9-754a-3c7a158daa56@nvidia.com>
 <CAHj4cs9ayQ8J+wDCWVKjmBTWTi7Bc3uqqTCDzL2ZY6JhpdDhsQ@mail.gmail.com>
 <1fda4154-50f4-c09d-dbb1-3b53ed63d341@nvidia.com>
 <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CAHj4cs_+yBbs+MgrC8Z8J7X8cKYwwr6wcR5tLfUCcYkftL7N1Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230627_234702_772316_4751F7DA 
X-CRM114-Status: UNSURE (   6.03  )
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

Yi,

Do you have hostnqn and hostid files in your /etc/nvme directory?

