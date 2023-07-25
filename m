Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 99624C0015E
	for <linux-nvme@archiver.kernel.org>; Tue, 25 Jul 2023 10:55:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=c4pVJ+uRAb/jeF46BJS6+DaJ28dAf3TVe5ufsFJerZA=; b=3u9DIbxaoG9tgOXRXwlo/aVect
	QeqccdubI/zIsoIKSJbtxwmN4QjnPgX9bpObuWbQgE+AJGVD5e8QpVF95LFVFBdhsBbwmj934GWoo
	aZfN0h/4HqEzPOukD0Sll41X7vEX9V0fpmaJojlhvxBEt4pMSBC9Jsk68U11DUnv4w+NN5iQ43gs5
	55yROGdvpT0JiTk2J0sLnAImwc62wtCpeifBFa+95rNbDl9EEwzzDU3gOFUZKPoG16UDsOczY5fV7
	hkM7sFgfxBJRuT0hcHRbgsx+OvGUxI5AKpYJ/EKrBpPM42rDdGzfGrlTKZHsmGdv0Kt/CqC5kjK64
	53PkZlAw==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.96 #2 (Red Hat Linux))
	id 1qOFh8-007GyO-1d;
	Tue, 25 Jul 2023 10:55:10 +0000
Received: from mail-lj1-f181.google.com ([209.85.208.181])
	by bombadil.infradead.org with esmtps (Exim 4.96 #2 (Red Hat Linux))
	id 1qOFh5-007GrR-0M
	for linux-nvme@lists.infradead.org;
	Tue, 25 Jul 2023 10:55:08 +0000
Received: by mail-lj1-f181.google.com with SMTP id 38308e7fff4ca-2b73261babdso14231181fa.1
        for <linux-nvme@lists.infradead.org>; Tue, 25 Jul 2023 03:55:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1690282504; x=1690887304;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=c4pVJ+uRAb/jeF46BJS6+DaJ28dAf3TVe5ufsFJerZA=;
        b=diWE467MQR3MSc6s9zKIkgQmQFfLgCLYHtUSpSMmFXw0I79BLXOzTj8pPhY0DpM4Br
         EqqKzKDQzgS8/e3wjdm/zVuMKDtg+/mRmk5rNrCqWR/lilQrXbJkM7AnDg82MG3V9qXM
         mjUXPM4XxeXokKOQMxucufFyCnFYO4LXSIfUNAi5oeTeM3sdH26leeoUA97S6dGqk8LP
         ATkvsHWglfEm0mqY3/UjOGFOcPoXEROZQXHwoUo2bS0Ic++4IqUorr2EhLR8roLovcvA
         V/cq4ZmeBaUPWCnIBvbMplZmGadM9qMdFsadp6WKZsBYcXnok43goDNp/qdge+XNIq10
         IzwA==
X-Gm-Message-State: ABy/qLYa04hvyYIrmO6vq98SvfbAn7aBcjSGRCRm8ecodxCzpNqWPjwx
	519JkNt6FGHUBwcN0BUyjsM9qFetYcE=
X-Google-Smtp-Source: APBJJlHc+AZ/yXiSUwjBcLfMzBfUGff+rG9jUEiJlbxQhUfeiy1pu7mbIt6twO9xatOcUZ+DEUIYJQ==
X-Received: by 2002:a05:651c:626:b0:2b6:cd7f:5ea8 with SMTP id k38-20020a05651c062600b002b6cd7f5ea8mr6026457lje.1.1690282503382;
        Tue, 25 Jul 2023 03:55:03 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s11-20020a5d4ecb000000b003144b50034esm15994992wrv.110.2023.07.25.03.55.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 25 Jul 2023 03:55:02 -0700 (PDT)
Message-ID: <676b7c2b-7bcf-6138-0229-389ed9efaa92@grimberg.me>
Date: Tue, 25 Jul 2023 13:55:00 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATH libnvme v1 1/2] fabrics: Shorten/rename supported option
 function/vars names
Content-Language: en-US
To: Daniel Wagner <dwagner@suse.de>
Cc: Caleb Sander <csander@purestorage.com>, Christoph Hellwig <hch@lst.de>,
 Keith Busch <kbusch@kernel.org>, linux-nvme@lists.infradead.org
References: <r3xuoptvmxqnbt6gi26b6av2jj4wbi3eixgd74lmdauxip63jt@pxmvqyljanjr>
 <20230725084137.16139-1-dwagner@suse.de>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20230725084137.16139-1-dwagner@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230725_035507_172763_AFA2B9A8 
X-CRM114-Status: GOOD (  23.64  )
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


> No need to be extra verbose and using so many chars per line.
> 
> Also rename to __nvmf_supported_options to nvmf_read_options
> which describes better what the function actually is doing.
> 
> Signed-off-by: Daniel Wagner <dwagner@suse.de>
> ---
>   src/nvme/fabrics.c | 8 ++++----
>   1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
> index 800293e2a8e7..2f26c2b7f39a 100644
> --- a/src/nvme/fabrics.c
> +++ b/src/nvme/fabrics.c
> @@ -202,7 +202,7 @@ const char *nvmf_cms_str(__u8 cm)
>    * Not all of these options may actually be supported,
>    * but we retain the old behavior of passing all that might be.
>    */
> -static const struct nvme_fabric_options default_supported_options = {
> +static const struct nvme_fabric_options default_options = {
>   	.ctrl_loss_tmo = true,
>   	.data_digest = true,
>   	.disable_sqflow = true,
> @@ -652,7 +652,7 @@ static int build_options(nvme_host_t h, nvme_ctrl_t c, char **argstr)
>   		continue;		   \
>   	}
>   
> -static  int __nvmf_supported_options(nvme_root_t r)
> +static int nvmf_read_options(nvme_root_t r)
>   {
>   	char buf[0x1000], *options, *p, *v;
>   	int fd, ret;
> @@ -683,7 +683,7 @@ static  int __nvmf_supported_options(nvme_root_t r)
>   			nvme_msg(r, LOG_DEBUG,
>   			         "Cannot read %s, using default options\n",
>   			         nvmf_dev);
> -			*r->options = default_supported_options;
> +			*r->options = default_options;
>   			ret = 0;
>   			goto out_close;
>   		}
> @@ -913,7 +913,7 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
>   		free(traddr);
>   	}
>   
> -	ret = __nvmf_supported_options(h->r);
> +	ret = nvmf_read_options(h->r);
>   	if (ret)
>   		return ret;
>   	ret = build_options(h, c, &argstr);

Why do we need an explicit call here?
Why it cannot be read on the first capability check?

Something like:
--
diff --git a/src/nvme/fabrics.c b/src/nvme/fabrics.c
index 800293e2a8e7..bb4bf2979eb0 100644
--- a/src/nvme/fabrics.c
+++ b/src/nvme/fabrics.c
@@ -357,10 +357,18 @@ static int __add_argument(char **argstr, const 
char *tok, const char *arg)
         return 0;
  }

+static int __nvmf_supported_options(nvme_root_t r);
+#define nvmf_check_option(r, tok)                                      \
+({                                                                     \
+       if (!(r)->options)                                              \
+               __nvmf_supported_options(r);                            \
+       (r)->options->tok;                                              \
+})
+
  #define add_bool_argument(o, argstr, tok, arg)                         \
  ({                                                                     \
         int ret;                                                        \
-       if (r->options->tok) {                                          \
+       if (nvmf_check_option(r, tok)) {                                \
                 ret = __add_bool_argument(argstr,                       \
                                           stringify(tok),               \
                                           arg);                         \
@@ -376,7 +384,7 @@ static int __add_argument(char **argstr, const char 
*tok, const char *arg)
  #define add_int_argument(o, argstr, tok, arg, allow_zero) \
  ({                                                                     \
         int ret;                                                        \
-       if (r->options->tok) {                                          \
+       if (nvmf_check_option(r, tok)) {                                \
                 ret = __add_int_argument(argstr,                        \
                                         stringify(tok),                 \
                                         arg,                            \
@@ -393,7 +401,7 @@ static int __add_argument(char **argstr, const char 
*tok, const char *arg)
  #define add_int_or_minus_one_argument(o, argstr, tok, arg)             \
  ({                                                                     \
         int ret;                                                        \
-       if (r->options->tok) {                                          \
+       if (nvmf_check_option(r, tok)) {                                \
                 ret = __add_int_or_minus_one_argument(argstr,           \
                                                      stringify(tok),    \
                                                      arg);              \
@@ -409,7 +417,7 @@ static int __add_argument(char **argstr, const char 
*tok, const char *arg)
  #define add_argument(r, argstr, tok, arg)
  ({                                                                     \
         int ret;                                                        \
-       if (r->options->tok) {                                          \
+       if (nvmf_check_option(r, tok)) {                                \
                 ret = __add_argument(argstr,                            \
                                      stringify(tok),                    \
                                      arg);                              \
@@ -913,9 +921,6 @@ int nvmf_add_ctrl(nvme_host_t h, nvme_ctrl_t c,
                 free(traddr);
         }

-       ret = __nvmf_supported_options(h->r);
-       if (ret)
-               return ret;
         ret = build_options(h, c, &argstr);
         if (ret)
                 return ret;
--

Then, we can spray options check wherever we want...
--
@@ -1026,8 +1031,10 @@ nvme_ctrl_t nvmf_connect_disc_entry(nvme_host_t h,
                 return NULL;
         }

-       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW)
+       if (e->treq & NVMF_TREQ_DISABLE_SQFLOW && 
nvmf_check_option(h->r, disable_sqflow))
                 c->cfg.disable_sqflow = true;
+       else
+               c->cfg.disable_sqflow = false;

         if (e->trtype == NVMF_TRTYPE_TCP &&
             (e->treq & NVMF_TREQ_REQUIRED ||
--

