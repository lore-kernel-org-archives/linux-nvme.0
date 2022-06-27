Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2CCB8C43334
	for <linux-nvme@archiver.kernel.org>; Mon, 27 Jun 2022 15:08:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=Fg8Bwv5jVOSC6SkiTFAem3LDnamS1A7nh56PccC959c=; b=oK4b66kzRNVt5cxyQGX22GMK9N
	2c1rNL0wKnM3XwnPyBzpNcUueK8jQBcuFBxw31irbRicTpcpeBpD80rkwMy5D5HymKp+CHhGPQt1R
	lhLwjDUFJgLCWWAfXVBduzcyEp7JCCrGjnc8W4AbSuuFOFFVYa+2R4pOA5e7JOKc2rcF5ZvKeNXtw
	IWfWc6V9DZU3KqQrKfVoECL8WtBFIzGr+JjM5jS2pIQKdP2gKs0Lke5VzTK1w0msUPkTZIluls3H0
	w+IRUCoJtSutaYpTQ4q/9HH6LMVk1FN4hGOZl32WjgL9VKLiX+DoDuvqI1hhhH7UzZMl4iaN0lp7q
	8yCCJ2eA==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qLk-001YAF-1d; Mon, 27 Jun 2022 15:08:28 +0000
Received: from mail-wm1-f50.google.com ([209.85.128.50])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1o5qLh-001Y9R-Fo
	for linux-nvme@lists.infradead.org; Mon, 27 Jun 2022 15:08:26 +0000
Received: by mail-wm1-f50.google.com with SMTP id g39-20020a05600c4ca700b003a03ac7d540so5025390wmp.3
        for <linux-nvme@lists.infradead.org>; Mon, 27 Jun 2022 08:08:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Fg8Bwv5jVOSC6SkiTFAem3LDnamS1A7nh56PccC959c=;
        b=jb/Ldp1hKz9hhraKREfUEA6YQmfmn6SPL9ry79XucefWVpWooQwDFRN2ZU/4wVaFPy
         wimj2ph4L9dlQJ6ZVVWuYMjxwM8S8QwZ3qhAEE6cInXFYYkeuTrmdAZTXxw0FtnEAM3j
         XJJjlJJIYkjvnpYhBwgbxDltRHPaQVEyLHWOP2nSrMyjnIeDlFEZfKCS2JVwo/qRn2UZ
         yzK/6AhpgMZb43VydfkBvZF66lDnLU1JVTInrXr9E/EzCXEWI63Fz4OC2dKdmVLhy2iy
         b7qOfi9IPZGYAJXX8//FlPu9WewOS8wEDBME7r0VVnLiitwiu+TCDPIUwoqmvZ2vAXQB
         Kz7Q==
X-Gm-Message-State: AJIora81Zzl2I0nHqNJNSc0lkt1eF94CZNoaViCsMuE17GkUnmcOGAqo
	cyJbEz0bP5/MEda0aVX5GxM=
X-Google-Smtp-Source: AGRyM1vxsMSVaiISI5H3d9Fd14USxAZs/GEQV7ya3Hwq8IRCa+xJ5MeAgvN5jakcVjkaXeNPyPKrGg==
X-Received: by 2002:a7b:c1cb:0:b0:3a0:4aec:7eb7 with SMTP id a11-20020a7bc1cb000000b003a04aec7eb7mr5524813wmj.96.1656342502343;
        Mon, 27 Jun 2022 08:08:22 -0700 (PDT)
Received: from [192.168.64.180] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id v15-20020a5d43cf000000b0021badf3cb26sm12878082wrr.63.2022.06.27.08.08.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jun 2022 08:08:21 -0700 (PDT)
Message-ID: <1bce9221-61e7-fd6d-198f-c77ba2e5e58b@grimberg.me>
Date: Mon, 27 Jun 2022 18:08:20 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] nvmetcli: support 'dhchap' attribute group
Content-Language: en-US
To: Hannes Reinecke <hare@suse.de>, Christoph Hellwig <hch@lst.de>
Cc: Keith Busch <keith.busch@wdc.com>, linux-nvme@lists.infradead.org
References: <20220323073316.15862-1-hare@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220323073316.15862-1-hare@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20220627_080825_575716_39A32E6E 
X-CRM114-Status: GOOD (  18.11  )
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


> NVMe authentication support added a new attribute group 'dhchap'
> to the host configfs directories. This patch adds functions to
> display and modify these entries from nvmetcli.
> 
> Signed-off-by: Hannes Reinecke <hare@suse.de>
> ---
>   nvmet/nvme.py | 2 ++
>   nvmetcli      | 4 ++++
>   2 files changed, 6 insertions(+)
> 
> diff --git a/nvmet/nvme.py b/nvmet/nvme.py
> index d170204..2ad9006 100644
> --- a/nvmet/nvme.py
> +++ b/nvmet/nvme.py
> @@ -892,6 +892,7 @@ class Host(CFSNode):
>           '''
>           super(Host, self).__init__()
>   
> +        self.attr_groups = ['dhchap']
>           self.nqn = nqn
>           self._path = "%s/hosts/%s" % (self.configfs_dir, nqn)
>           self._create_in_cfs(mode)
> @@ -913,6 +914,7 @@ class Host(CFSNode):
>           except CFSError as e:
>               err_func("Could not create Host object: %s" % e)
>               return
> +        h._setup_attrs(t, err_func)
>   
>       def dump(self):
>           d = super(Host, self).dump()
> diff --git a/nvmetcli b/nvmetcli
> index 8ee8590..8da379b 100755
> --- a/nvmetcli
> +++ b/nvmetcli
> @@ -661,6 +661,10 @@ class UIHostNode(UINode):
>       def __init__(self, parent, cfnode):
>           UINode.__init__(self, cfnode.nqn, parent, cfnode)
>   
> +    def summary(self):
> +        info = []
> +        info.append("key=" + self.cfnode.get_attr("dhchap", "key"))
> +        return (", ".join(info), True)


We shouldn't have a UI to the secrets themselves I think, we probably
should do this instead:
diff --git a/nvmetcli b/nvmetcli
index 8da379bde9db..b06039b2338d 100755
--- a/nvmetcli
+++ b/nvmetcli
@@ -663,7 +663,14 @@ class UIHostNode(UINode):

      def summary(self):
          info = []
-        info.append("key=" + self.cfnode.get_attr("dhchap", "key"))
+        if self.cfnode.get_attr("dhchap", "key"):
+            info.append("hostkey=set")
+        else:
+            info.append("hostkey=unset")
+        if self.cfnode.get_attr("dhchap", "ctrl_key"):
+            info.append("ctrlkey=set")
+        else:
+            info.append("ctrlkey=unset")
          return (", ".join(info), True)

  def usage():

