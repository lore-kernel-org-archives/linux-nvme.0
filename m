Return-Path: <SRS0=GxYq=6W=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7F517C35280
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 00:50:52 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 3BD40208CA
	for <linux-nvme@archiver.kernel.org>; Fri,  8 May 2020 00:50:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="s0fJkGCj"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 3BD40208CA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:Cc:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=0VO/OlnMj7CAj0lSY5Wy7q26Qy8sIJFYg82DAffx65U=; b=s0fJkGCjzRL2cui3Tmwa9Iusb
	2xNEBjvMn7NpgCYnPIQneiBhLFcBNl+220IJj8jNiI49QOMhr5s8oRY3ky2E+F5aelslbXiA7NfDV
	nSNEwNxhUbZuVJg9PDaQh4ErI0ZTB86IWzcTAUFxwx0EaXdaLEgTwHs8SY/dwtQq/ViVEtYYzZruH
	u0EET3N5TNhjBnhcH8Jrd2nEkWSQ8JlWeQqmdTDhGDDfdVJURYAOTt+BdhPWE7ivlkDWUNoEtA8VY
	4+W7uq22ql2CsZn7HK4SqqDMhPHIeyZ2lluj8ufOJknI/wD7ibI+EMqMbw5D56sjXXwyzZxkw63Rl
	WmCLQWgEw==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1jWrDy-00087t-65; Fri, 08 May 2020 00:50:46 +0000
Received: from mail-pj1-f67.google.com ([209.85.216.67])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1jWrDu-00086r-SC
 for linux-nvme@lists.infradead.org; Fri, 08 May 2020 00:50:44 +0000
Received: by mail-pj1-f67.google.com with SMTP id t9so3472627pjw.0
 for <linux-nvme@lists.infradead.org>; Thu, 07 May 2020 17:50:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=yGfg/fQ/MRyv5Vyqp/Fsoxvep68YojFgVvSLBjUd/ws=;
 b=dBy/PmI7T2jfO1M+jvLhkrDpB4LMQZGbMiUYqI6wExWZL0B0Lgx473SLLLBnoblAsL
 xB3hdmLgsgjpUtbNR87VzML0nti8VZ8gxoOx4mOZtnmYmEYtUZ2/wM1TmNhrvRjMlIFn
 oRGKYY1WRipLW0V+ZKAcUk+OAaY2xDTPRNAq2WdL/Ot7g8yfMTG4yNTAPqWsBF7NiyHF
 sv60C6LKabVzOS/MnGlfeUPM7HQN+SpHv03JPR/e+/KvbCTE69RJeDKw0XKNeHxRuoWJ
 o8IkMUWllW8ClcSSS+AZ96piaXzHfum1HVJtynZWDoxwJWKTDdyUxaUYPnN5wZU5CgDj
 jLDA==
X-Gm-Message-State: AGi0PubzJBiEyqC77bEURvPhRn0Kh1bK8/+HJe50WQzR/iO4Cq1U58wk
 bLUZmtzYCO2P/SjBzYTLW9f2b5tY
X-Google-Smtp-Source: APiQypKjuiV7AQVSQOErlc5t8ohFjsVaxk/yayqqKRwDpMu3vltqRDQqX3i/Eqfa3GvelkrQdp/4lQ==
X-Received: by 2002:a17:90a:a893:: with SMTP id
 h19mr3045344pjq.138.1588899040863; 
 Thu, 07 May 2020 17:50:40 -0700 (PDT)
Received: from ?IPv6:2601:647:4802:9070:6507:baa2:4de7:40e9?
 ([2601:647:4802:9070:6507:baa2:4de7:40e9])
 by smtp.gmail.com with ESMTPSA id q7sm90308pgs.13.2020.05.07.17.50.39
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Thu, 07 May 2020 17:50:40 -0700 (PDT)
Subject: Re: [PATCH 1/2] nvme-tcp: set MSG_SENDPAGE_NOTLAST with MSG_MORE when
 we have more to send
To: Christoph Hellwig <hch@lst.de>
References: <20200505052002.14924-1-sagi@grimberg.me>
 <20200505060907.GA3995@lst.de>
 <f0f28e18-c432-8343-f7a7-79cb3159b43c@grimberg.me>
 <20200505102354.GB15038@lst.de>
 <6abf2183-ea1e-d1e0-360c-5d74b75c3690@grimberg.me>
 <20200506042734.GA9542@lst.de>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <ced17f23-0bfc-d076-7c20-ad02c1b54786@grimberg.me>
Date: Thu, 7 May 2020 17:50:38 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Firefox/68.0 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200506042734.GA9542@lst.de>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20200507_175042_908989_94C76F0F 
X-CRM114-Status: GOOD (  13.07  )
X-BeenThere: linux-nvme@lists.infradead.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: <linux-nvme.lists.infradead.org>
List-Unsubscribe: <http://lists.infradead.org/mailman/options/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=unsubscribe>
List-Archive: <http://lists.infradead.org/pipermail/linux-nvme/>
List-Post: <mailto:linux-nvme@lists.infradead.org>
List-Help: <mailto:linux-nvme-request@lists.infradead.org?subject=help>
List-Subscribe: <http://lists.infradead.org/mailman/listinfo/linux-nvme>,
 <mailto:linux-nvme-request@lists.infradead.org?subject=subscribe>
Cc: Keith Busch <kbusch@kernel.org>,
 Mark Wunderlich <mark.wunderlich@intel.com>,
 Anil Vasudevan <anil.vasudevan@intel.com>, linux-nvme@lists.infradead.org
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org


>>> What I mean is that nvmet_try_send_data and nvmet_try_send_ddgst may set
>>> neither MS_MORE nor MSG_EOR.  Is that intentional?
>>
>> nvmet_try_send_data should set MSG_EOR if it doesn't have more to send
>> and also nvmet_try_send_ddgst. So its not intentional.
> 
> Ok.  Can you send it with a little helper like I suggested (probably one
> each for host and target) that ensures the right flags are set
> everywhere?

I think its actually better without the helper. MSG_SENDPAGE_NOTLAST is
designed only for sendpage and not for sendmsg which we use for ddgst
(although the net stack code appears to ignore, but still) and when we
send a pdu header that has data, we dont need the condition because its
not last for sure.

So the helpers capture ~60% of the call-sites... seems to me like its
better off without them at the moment. WDYT?

_______________________________________________
linux-nvme mailing list
linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
