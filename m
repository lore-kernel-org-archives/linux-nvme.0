Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B7A5C433F5
	for <linux-nvme@archiver.kernel.org>; Sun, 12 Dec 2021 09:45:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:
	Subject:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=WHTBMchp3KBXczwZZpIAn+znCy/DsPxuUlwcS/DxvDk=; b=ulCFFq7vE541fKAIc/7kIqiTyO
	srcA5i3J49UrxVToLtu3SA0FEHbpRDRAF6k0nnMr4tZY9iL5vetn07H/gPyILIehSG/LcIkTAgfcq
	8XUKz7CaCiz4TlHmioedepil9add6/9M+2allSPPWef2j9m9mvWCd4OmFm6apAlwQvIXdeklQ8z0O
	79Kqn+R8E+7zjZJyya5cDWNQmUYQY2O98QnoD6El1r4D4MeoKQ+rK15VMJdK2AzH975lMpY/GXE+s
	naaE1uRGubzDAAs1SkRhn/hiAncvdurFhfUeE2Modq29k7xxGPgkwYuM+7QM+rO/OSKnwM5uPVefT
	pSI0/hKA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1mwLQX-006Flg-4T; Sun, 12 Dec 2021 09:45:53 +0000
Received: from mail-wm1-f52.google.com ([209.85.128.52])
 by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
 id 1mwLQU-006Fl1-Be
 for linux-nvme@lists.infradead.org; Sun, 12 Dec 2021 09:45:52 +0000
Received: by mail-wm1-f52.google.com with SMTP id
 p3-20020a05600c1d8300b003334fab53afso12071986wms.3
 for <linux-nvme@lists.infradead.org>; Sun, 12 Dec 2021 01:45:49 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20210112;
 h=x-gm-message-state:subject:to:cc:references:from:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=WHTBMchp3KBXczwZZpIAn+znCy/DsPxuUlwcS/DxvDk=;
 b=p4X3ZrIUgYP5ZFt8Y0I55UBjuxWpD7KyfYTGOU3gTxk6FdT5I6470gq/DZVyYohNjR
 cVVr+nTKbEOTSBRD6LuDQM8Uzyg/8oWZNZ3oKDtZ63vrHiUI1uVQqPkMrrtJqr3Mj2Bl
 TUxRUuiRsfw1AFX5LJt9jlvsetv0MEXyyPafgqi/R4ZloOm5Sxr1VsGFN9hD3sAZU9NM
 iaRQK95dwjuq/hTYYluNFq6tx+RljbMg61zxa2p/qeFI4WQv+8AGTvWNNekexRxGHbs/
 SxeZD3nJEjDjSSEmlMGaEnMmfYAyniW1pll1ehUD6+MwiIIfEu+JH25LW6HuNLI+nf8J
 IwXA==
X-Gm-Message-State: AOAM531PEok5/Fv6V4vEHZV6FJR1UQ9smTfP4YNPTtkES8pfe0T+/0tG
 jDP9yOvmnAAO50gk3ClNhZ8=
X-Google-Smtp-Source: ABdhPJwTcf2pLOyJ1ubM4Y8aZce0OOmggNf36Gt19UoUVjrQumDADB1GEIBKSLdgIDanHjoVwgDmvw==
X-Received: by 2002:a05:600c:378b:: with SMTP id
 o11mr29794895wmr.157.1639302348787; 
 Sun, 12 Dec 2021 01:45:48 -0800 (PST)
Received: from [192.168.64.123] (bzq-219-42-90.isdn.bezeqint.net.
 [62.219.42.90])
 by smtp.gmail.com with ESMTPSA id r11sm7115126wrw.5.2021.12.12.01.45.47
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Sun, 12 Dec 2021 01:45:48 -0800 (PST)
Subject: Re: [bug report] NVMe/IB: reset_controller need more than 1min
To: Yi Zhang <yi.zhang@redhat.com>
Cc: "open list:NVM EXPRESS DRIVER" <linux-nvme@lists.infradead.org>,
 RDMA mailing list <linux-rdma@vger.kernel.org>
References: <CAHj4cs8cT23z+h2i+g6o3OQqEhWnHS88JO4jNoQo0Nww-sdkYg@mail.gmail.com>
 <3c86dc88-97d9-5a71-20e1-a90279f47db5@grimberg.me>
 <CAHj4cs_3eLZd=vxRRrnBU2W4H38mqttcy0ZdSw6uw4KvbJWgeQ@mail.gmail.com>
 <CAHj4cs_VZ7C7ciKy-q51a+Gc=uce0GDKRHNmUdoGOd7KSvURpA@mail.gmail.com>
 <84208be5-a7a9-5261-398c-fa9bda3efbe3@grimberg.me>
 <CAHj4cs8dgNNE5qcX3Y4ykuTYU8z_kea6=q64Pn_2vsdodgOJZQ@mail.gmail.com>
 <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
From: Sagi Grimberg <sagi@grimberg.me>
Message-ID: <9f115198-bafc-be4e-1c90-06444b8a37f6@grimberg.me>
Date: Sun, 12 Dec 2021 11:45:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAHj4cs-aDo7DufnKazyKuZVR-1AWr5FK1LDsN=Do=CVUJ2pH3g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20211212_014550_802252_A80E7D64 
X-CRM114-Status: GOOD (  20.25  )
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



On 12/11/21 5:01 AM, Yi Zhang wrote:
> On Fri, Jun 25, 2021 at 12:14 AM Yi Zhang <yi.zhang@redhat.com> wrote:
>>
>> On Thu, Jun 24, 2021 at 5:32 AM Sagi Grimberg <sagi@grimberg.me> wrote:
>>>
>>>
>>>> Hello
>>>>
>>>> Gentle ping here, this issue still exists on latest 5.13-rc7
>>>>
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 0m12.636s
>>>> user 0m0.002s
>>>> sys 0m0.005s
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 0m12.641s
>>>> user 0m0.000s
>>>> sys 0m0.007s
>>>
>>> Strange that even normal resets take so long...
>>> What device are you using?
>>
>> Hi Sagi
>>
>> Here is the device info:
>> Mellanox Technologies MT27700 Family [ConnectX-4]
>>
>>>
>>>> # time nvme reset /dev/nvme0
>>>>
>>>> real 1m16.133s
>>>> user 0m0.000s
>>>> sys 0m0.007s
>>>
>>> There seems to be a spurious command timeout here, but maybe this
>>> is due to the fact that the queues take so long to connect and
>>> the target expires the keep-alive timer.
>>>
>>> Does this patch help?
>>
>> The issue still exists, let me know if you need more testing for it. :)
> 
> Hi Sagi
> ping, this issue still can be reproduced on the latest
> linux-block/for-next, do you have a chance to recheck it, thanks.

Can you check if it happens with the below patch:
--
diff --git a/drivers/nvme/target/fabrics-cmd.c 
b/drivers/nvme/target/fabrics-cmd.c
index f91a56180d3d..6e5aadfb07a0 100644
--- a/drivers/nvme/target/fabrics-cmd.c
+++ b/drivers/nvme/target/fabrics-cmd.c
@@ -191,6 +191,14 @@ static u16 nvmet_install_queue(struct nvmet_ctrl 
*ctrl, struct nvmet_req *req)
                 }
         }

+       /*
+        * Controller establishment flow may take some time, and the 
host may not
+        * send us keep-alive during this period, hence reset the
+        * traffic based keep-alive timer so we don't trigger a
+        * controller teardown as a result of a keep-alive expiration.
+        */
+       ctrl->reset_tbkas = true;
+
         return 0;

  err:
--

