Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C7F5C636CC
	for <linux-nvme@archiver.kernel.org>; Wed, 15 Feb 2023 08:41:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=08Vd0YkR6ah7C2fvYViAaf1xNM3/epxKLvcs+NlG88k=; b=i1N/IRQLRDR05Tj0dFxp1TqYxp
	J9GIvVD/wWvFZ7cvqaJn6mUa6tAOUnuF2752m1r8Hf9fJG96sA5eiHOfPkm+PWEfFbz7aUyAYOVO1
	CbXaZmJ5iDoSr15kOj+kNGy4f55djmctPhLSYlLkz7LaKY0YfmFCs0QLAqil+3nYbpp8zVFc9Zfo1
	UfREA0AcGyS3GW/BFNCe1eXIXX1kQGfpEp5dI8tMVUsIyirp6ftx5JxplOYvN/97bjBqg6G1Eu+Y2
	8eglkU+ZKDsCMDl+9btUpFJnpuAWzRamMargKvIdDxe/p9Nx03ahGUZjDpAS9/p+FsTpAl/C3lNYI
	Sdz3OF3w==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSDLo-005CKF-Ec; Wed, 15 Feb 2023 08:41:16 +0000
Received: from mail-wm1-f43.google.com ([209.85.128.43])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1pSDLl-005CJN-Ty
	for linux-nvme@lists.infradead.org; Wed, 15 Feb 2023 08:41:15 +0000
Received: by mail-wm1-f43.google.com with SMTP id z13so12756236wmp.2
        for <linux-nvme@lists.infradead.org>; Wed, 15 Feb 2023 00:41:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676450470;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=08Vd0YkR6ah7C2fvYViAaf1xNM3/epxKLvcs+NlG88k=;
        b=tN7oyFXaKUJO5L9tMIZFtHiix0lsxMENzPxYbLNtTre/cjCWiGVrHOCaJJQUfDHGMq
         7O7dhXhmk9iKbzGXVkvGbD6CUTGfvn3gk+GI/X6QIb1YPjgs0SGhZvq71BkawIZgOVzc
         nz1pIJqq8r+OKkzXFGHlokTTT88/h4MiR0BSank+FPz44e1GCzC3udAXya2TCkLjqzlO
         wX/Obq+ZQUNk33FTZq9D3SP3uPA3ZQbI4hn0/hXzel4yGuB1W768HzgSXv3m3KDi9qxq
         Pz2JO16ZT/xFcH/BqVF0QEsg+qiSdqIb9l9TR1L5VRDBeZmFUW+dG2IySl6KSkRiI1Ja
         b/Og==
X-Gm-Message-State: AO0yUKWCqicoKWvjzuPXGvotRxzM7DSn20VWkwCncgAlf2+y2O5HLpDl
	78HhqFR+jcy5WCqBZun2hLE=
X-Google-Smtp-Source: AK7set8RYyVJ0XXEFa7dMSDs6AF5t9y1UMfdDGbKDcToVe+SsfBJQFo5X4qyRiPjFZ3YlFDBjJZOuw==
X-Received: by 2002:a05:600c:1c2a:b0:3db:2063:425e with SMTP id j42-20020a05600c1c2a00b003db2063425emr1563674wms.1.1676450470475;
        Wed, 15 Feb 2023 00:41:10 -0800 (PST)
Received: from [192.168.64.80] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003db06224953sm1407153wmo.41.2023.02.15.00.41.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 00:41:10 -0800 (PST)
Message-ID: <7f958c6d-d6e6-2346-a680-875c7fafe7e5@grimberg.me>
Date: Wed, 15 Feb 2023 10:41:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: How to look up an ns cdev from block maj:min?
Content-Language: en-US
To: Stefan Hajnoczi <stefanha@redhat.com>, linux-nvme@lists.infradead.org
References: <Y+v8x4m3lm8QU7Ov@fedora>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <Y+v8x4m3lm8QU7Ov@fedora>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20230215_004113_997482_813A2461 
X-CRM114-Status: GOOD (  18.14  )
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


> Hi,
> Is there an official way for userspace to look up an ns cdev from a
> block maj:min?
> 
> For example, how should a userspace program determine that /dev/ng0n1 is
> the corresponding ns cdev when given just the block device node
> /dev/nvme0n1?
> 
> Parsing the filename is an obvious option but it makes assumptions about
> the naming convention of both the block device node and the character
> device node.
> 
> Is there a better way via sysfs? (I couldn't find it.)

Not that I can see... It follows the same rules as the
normal namespace, which means that it takes the subsystem or ctrl
instance number (depending if multipathing is enabled) and it will have
the same namespace instance number.

In other words, every namespace nvmeXnY will present an 'nvme generic'
chardev in the form of ngXnY.

Looks like nvme-cli is missing the generic representation in the json
output as well. Perhaps that is the best tool to use (once fixed with
the json output with the below):

--
diff --git a/nvme-print-json.c b/nvme-print-json.c
index df5616e88119..489e9e15c3b5 100644
--- a/nvme-print-json.c
+++ b/nvme-print-json.c
@@ -2507,6 +2507,7 @@ static void json_detail_list(nvme_root_t r)
                                         uint64_t nuse = 
nvme_ns_get_lba_util(n) * lba;

 
json_object_add_value_string(jns, "NameSpace", nvme_ns_get_name(n));
+ 
json_object_add_value_string(jns, "Generic", nvme_ns_get_generic_name(n));
                                         json_object_add_value_int(jns, 
"NSID", nvme_ns_get_nsid(n));
 
json_object_add_value_uint64(jns, "UsedBytes", nuse);
 
json_object_add_value_uint64(jns, "MaximumLBA", nvme_ns_get_lba_count(n));
@@ -2565,15 +2566,18 @@ static struct json_object 
*json_list_item(nvme_ns_t n)
  {
         struct json_object *jdevice = json_create_object();
         char devname[128] = { 0 };
+       char genname[128] = { 0 };

         int lba = nvme_ns_get_lba_size(n);
         uint64_t nsze = nvme_ns_get_lba_count(n) * lba;
         uint64_t nuse = nvme_ns_get_lba_util(n) * lba;

         nvme_dev_full_path(n, devname, sizeof(devname));
+       nvme_generic_full_path(n, genname, sizeof(genname));

         json_object_add_value_int(jdevice, "NameSpace", 
nvme_ns_get_nsid(n));
         json_object_add_value_string(jdevice, "DevicePath", devname);
+       json_object_add_value_string(jdevice, "GenericPath", genname);
         json_object_add_value_string(jdevice, "Firmware", 
nvme_ns_get_firmware(n));
         json_object_add_value_string(jdevice, "ModelNumber", 
nvme_ns_get_model(n));
         json_object_add_value_string(jdevice, "SerialNumber", 
nvme_ns_get_serial(n));
diff --git a/nvme-print.c b/nvme-print.c
index fee9aabfc176..ec98fe304c4b 100644
--- a/nvme-print.c
+++ b/nvme-print.c
@@ -5108,7 +5108,7 @@ void nvme_dev_full_path(nvme_ns_t n, char *path, 
size_t len)
         snprintf(path, len, "%s", nvme_ns_get_name(n));
  }

-static void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len)
+void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len)
  {
         int head_instance;
         int instance;
diff --git a/nvme-print.h b/nvme-print.h
index ab11774daa28..7a4ceeea5131 100644
--- a/nvme-print.h
+++ b/nvme-print.h
@@ -149,6 +149,7 @@ const char *nvme_feature_to_string(enum 
nvme_features_id feature);
  const char *nvme_register_to_string(int reg);

  void nvme_dev_full_path(nvme_ns_t n, char *path, size_t len);
+void nvme_generic_full_path(nvme_ns_t n, char *path, size_t len);
  char *zone_type_to_string(__u8 cond);
  char *zone_state_to_string(__u8 state);
  const char *nvme_pel_event_to_string(int type);
--


