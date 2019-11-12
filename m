Return-Path: <SRS0=/X2o=ZE=lists.infradead.org=linux-nvme-bounces+linux-nvme=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 30F7FC43331
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 19:02:04 +0000 (UTC)
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 06DEA206BA
	for <linux-nvme@archiver.kernel.org>; Tue, 12 Nov 2019 19:02:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lists.infradead.org header.i=@lists.infradead.org header.b="qR85CS4c"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 06DEA206BA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=grimberg.me
Authentication-Results: mail.kernel.org; spf=none smtp.mailfrom=linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20170209; h=Sender:Content-Type:
	Content-Transfer-Encoding:List-Subscribe:List-Help:List-Post:List-Archive:
	List-Unsubscribe:List-Id:In-Reply-To:MIME-Version:Date:Message-ID:From:
	References:To:Subject:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:
	Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	 bh=zQk+RT5vF2Byr8XvJRPjM/vd4EVBiCkc936IKq+6RCc=; b=qR85CS4c7KIXpXARks/RdaV/k
	/1ohM0Xi1KtMua1tOKrvAJSpTOV8qEWoq+Q0NEPB4hlmsnOJsmNac3CFK0cx4EynB7zPaQ63x0Iio
	Gt6vgkvsYgfrHEOS9vvdDNxziJjoyXENw09zRAB9blgCBCdf4T4PLXQjA76bcUsAq0tzPSM3doiXI
	XeObEs4snDzmZ3JlgBawHxzS/7BJ9yXUX9/6WU4gM7rFgx8TkxB5hJAWfdnwYO1jwzlx45ZB755KQ
	LolC9rQpHQxwWDD0ZbS0O+joiPjTi9V7j7GsPpfLVbXemuHCWg0gCmXEjfqPfHBErAKbSWn7WGTX8
	qPAInIOfg==;
Received: from localhost ([127.0.0.1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.92.3 #3 (Red Hat Linux))
	id 1iUbQP-0003eL-CR; Tue, 12 Nov 2019 19:02:01 +0000
Received: from mail-oi1-f194.google.com ([209.85.167.194])
 by bombadil.infradead.org with esmtps (Exim 4.92.3 #3 (Red Hat Linux))
 id 1iUbQM-0003dk-46
 for linux-nvme@lists.infradead.org; Tue, 12 Nov 2019 19:01:59 +0000
Received: by mail-oi1-f194.google.com with SMTP id l202so15845293oig.1
 for <linux-nvme@lists.infradead.org>; Tue, 12 Nov 2019 11:01:57 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:subject:to:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=HS4e9PQegMjZAEwXZUf0IENV2d0BANzy83wd1clmBoQ=;
 b=kySrpskv8My6+TXOc2j1Hz9xMulxx0QidKLw0i6Rz8weZwfhD1ifgzbJLt7JdnIgQy
 mQja09McIiln9QsOowGWXguMwEpHt03gsabmF9dY7zxRsjw1B7k1ehD0Mblsv7XXzLOv
 PRJ4w7CZr7sPSsD0mjzZscw0+lUYyur06T0bHCaqJrQYQAbFDPsb76cfwBpnSgxVynGF
 P5I9BF9zx4upQWwevxrgEIkZqWeqr/8HYNnO/bALpSxb4W0HIzwa/apcJGoYDmoMpAxL
 rEFhTk/vKxs42anHbYKXKNEPWZwa9UYE4RQIS+UMSlj9yZNt9GldSCBmc0oRh5AOsnoW
 KFJg==
X-Gm-Message-State: APjAAAV7hzJlUjsMpVo0zonpPK035Ftaxljx+CNlLMxcIcugnKOwavzQ
 REsfsn91C91swBImYcEqPd1Yjki0
X-Google-Smtp-Source: APXvYqyotKdwKx9UT1/RLwIEMlzLJsiv0PcvY43iPq5Wy3nFextYoaa3DrMMZomptoVczcrI88sX8Q==
X-Received: by 2002:aca:f495:: with SMTP id s143mr409098oih.75.1573585316707; 
 Tue, 12 Nov 2019 11:01:56 -0800 (PST)
Received: from [192.168.1.114]
 (162-195-240-247.lightspeed.sntcca.sbcglobal.net. [162.195.240.247])
 by smtp.gmail.com with ESMTPSA id y1sm6614375ota.72.2019.11.12.11.01.55
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Tue, 12 Nov 2019 11:01:55 -0800 (PST)
Subject: Re: [PATCH] nvmet: make ctrl-id configurable
To: Mark Ruijter <MRuijter@onestopsystems.com>,
 James Smart <james.smart@broadcom.com>, Max Gurtovoy <maxg@mellanox.com>,
 Chaitanya Kulkarni <chaitanya.kulkarni@wdc.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <20191103181343.3011-1-chaitanya.kulkarni@wdc.com>
 <409804f3-158b-cc3e-9b04-6499bfe1638d@mellanox.com>
 <3381ACB3-3ACC-4124-8925-09CED68BA11E@onestopsystems.com>
 <b79e612f-4b49-a80f-bc34-e672ae98c1af@mellanox.com>
 <B500B4ED-DF25-41F3-83F8-6E239718564A@onestopsystems.com>
 <c8472575-1041-c44e-e26a-1201161c22c6@broadcom.com>
 <802cb171-34de-65cc-75c5-83ef7c200dc4@grimberg.me>
 <3D590371-4C4F-4355-B36E-7795FB218FC6@onestopsystems.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <2f3ea2c4-f59a-22e3-ed09-91cf737818ea@grimberg.me>
Date: Tue, 12 Nov 2019 11:01:51 -0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <3D590371-4C4F-4355-B36E-7795FB218FC6@onestopsystems.com>
Content-Language: en-US
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20191112_110158_163257_2E1B5A06 
X-CRM114-Status: GOOD (  20.05  )
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
Content-Transfer-Encoding: 7bit
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Sender: "Linux-nvme" <linux-nvme-bounces@lists.infradead.org>
Errors-To: linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org



On 11/8/19 8:15 AM, Mark Ruijter wrote:
> 
> I have setup a cluster using two nodes with a dual ported nvme drive and tested exporting the drive from both nodes.
> 
> The configuration on both nodes, with the exception of the ip address, looks like this:
>      {
>        "addr": {
>          "adrfam": "ipv4",
>          "traddr": "192.168.1.11",
>          "treq": "not specified",
>          "trsvcid": "4420",
>          "trtype": "tcp"
>        },
>        "portid": 322,
>        "referrals": [],
>        "subsystems": [
>          "clvol"
>        ]
>      },
> 
>    "subsystems": [
>      {
>        "allowed_hosts": [],
>        "attr": {
>          "allow_any_host": "1",
>          "model": "clpool/clvol",
>          "serial": "e94430920f6103af",
>          "version": "1.3"
>        },
>        "namespaces": [
>          {
>            "device": {
>              "nguid": "00000000-0000-0000-0000-000000000000",
>              "path": "/dev/clpool/clvol",
>              "uuid": "99451596-9675-4382-bff8-b78ee34de567"
>            },
>            "enable": 1,
>            "nsid": 1
>          }
>        ],
>        "nqn": "clvol"
>      },
> 
> When I now connect the initiator to the two cluster nodes without the patch the result will be a controller id collision.
> And the initiator refuses to connect to the second node that you try to connect.
> --
> [ 7895.052302] nvme nvme0: new ctrl: NQN "clvol", addr 192.168.8.10:4420
> [ 7895.053297] nvme0n1: detected capacity change from 0 to 107374182400
> [ 7898.188321] nvme nvme1: Duplicate cntlid 1 with nvme0, rejecting
> --
> 
> With the attached patch I am able to force the second node to use a higher offset when enumerating controller ids:
> nodea:
> /sys/kernel/config/nvmet/subsystems/clvol # cat cntlid_min
> 1
> nodeb:/sys/kernel/config/nvmet/subsystems/clvol # cat cntlid_min
> 32
> 
> In real life the number used for the offsets could be derived from something like the Pacemaker node number.
> And the Pacemaker + DLM could be used for nvme persistent reservations.
> 
> The controller id collision now no longer occurs.
> And the initiator can connect, and two paths will be shown:
> 
> root@r11i1:~# nvme list-subsys
> nvme-subsys0 - NQN=clvol
> \
>   +- nvme0 tcp traddr=192.168.1.10 trsvcid=4420
>   +- nvme1 tcp traddr=192.168.1.11 trsvcid=4420
> 
> Does this all make sense?

I think we need a cntlid_max to make sure we don't have collisions..

_______________________________________________
Linux-nvme mailing list
Linux-nvme@lists.infradead.org
http://lists.infradead.org/mailman/listinfo/linux-nvme
