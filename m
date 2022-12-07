Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A5AFC4708E
	for <linux-nvme@archiver.kernel.org>; Wed,  7 Dec 2022 15:16:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Cc:Content-ID:Content-Description:Resent-Date:Resent-From
	:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=7XsRuZ7qY1tD0l/2EkMQdpZq+4s50uESfZplCDbUFE0=; b=RugiIxnQ60Elq5qqg/n35r8FaR
	lTmX3pFnuTHwV66tXjwA1dLqS2ppgVXvPe3HRd2lPBTru4ywbwaZHDs5ah45wTMhAzdg+W9/9pN3k
	H0wQnc4KMorj9nfCxUBZNzhNYhjohTwgUC1sqmM+71qm8J/gIiTqr85hVGuh8haqmh+xYPlyFU/Cl
	9Uthuw02/KibIXSLX0nVvVUeCGJ5OPcnjc/WgYqAA9JFjEe47gODXOAf3kcf4cC9v0qHLSsaVPQ3y
	z3ClLODJVRZsJXGWUoZ3xDeaeLThuRtfDpA3NHT4OzZZfSvHrsFgxtCe/+4l91p05AMxPhUoAmOxv
	Zg8NCbCQ==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wA4-005gf6-8Q; Wed, 07 Dec 2022 15:16:40 +0000
Received: from mail-wm1-f46.google.com ([209.85.128.46])
	by bombadil.infradead.org with esmtps (Exim 4.94.2 #2 (Red Hat Linux))
	id 1p2wA1-005gWO-64
	for linux-nvme@lists.infradead.org; Wed, 07 Dec 2022 15:16:39 +0000
Received: by mail-wm1-f46.google.com with SMTP id bg10so13879849wmb.1
        for <linux-nvme@lists.infradead.org>; Wed, 07 Dec 2022 07:16:33 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7XsRuZ7qY1tD0l/2EkMQdpZq+4s50uESfZplCDbUFE0=;
        b=j693yaLemvgTFdCKmniQBpA/A5nSkLW+E+KrGUtRau7BmxGDJTooE6lcEuwz60Pfhl
         kTQsLwBUf/DLhXR7L1USsQcDybEjdjVxoNEENSl50NRd20I+BwfhH/Jip6sEz//ATB7M
         tgW3VFGHvQPWhVB5NoKIBv5V0JE2QnWU2JZj3fsiN+uEniBh2L7Ec1CvRzaT47KNTg50
         u6mRSPytUJkNFd4VIz3V1RsnEmVA28PJhAzPtMChtfg7oD/LFTGbkUbwvWV12xbf9l1o
         vkuXheRucnADbCTO3f4QAFrwEhCIGPf5gYWpodgsnAn8LnBW4rquCfJp0q5WSNw6NDlv
         /Xdg==
X-Gm-Message-State: ANoB5plEMrWu5pnz/M2/NrTKXvk2xRSel7DffnW3op+y+iYM+7R/XmM9
	q7HRfqy87NAIBPz4LiyzNeDuvH76ORs=
X-Google-Smtp-Source: AA0mqf5rYO3HPJsYt+Rm0v8XOPItuhom4UsraN0ocHtn8OCccl58zm/+zCwP8fEp8B2uE3Nj6OZ/6A==
X-Received: by 2002:a05:600c:1f1b:b0:3cf:35c8:289f with SMTP id bd27-20020a05600c1f1b00b003cf35c8289fmr59229629wmb.153.1670426192361;
        Wed, 07 Dec 2022 07:16:32 -0800 (PST)
Received: from [192.168.64.178] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id h41-20020a05600c49a900b003c6bd91caa5sm1895834wmp.17.2022.12.07.07.16.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:16:31 -0800 (PST)
Message-ID: <769ace6a-4eac-bef5-12f2-8f1f45875c6d@grimberg.me>
Date: Wed, 7 Dec 2022 17:16:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] nvme-tcp: add additional info for nvme_tcp_timeout log
Content-Language: en-US
To: "Engel, Amit" <Amit.Engel@Dell.com>,
 "linux-nvme@lists.infradead.org" <linux-nvme@lists.infradead.org>
References: <1669889667-1034818-1-git-send-email-amit.engel@dell.com>
 <1670410707-2278352-1-git-send-email-amit.engel@dell.com>
 <40ec518c-db1b-8fa2-af66-3b2f3dcc235d@grimberg.me>
 <CO1PR19MB4885380AC6E687A3FC8A858EEE1A9@CO1PR19MB4885.namprd19.prod.outlook.com>
From: Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <CO1PR19MB4885380AC6E687A3FC8A858EEE1A9@CO1PR19MB4885.namprd19.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20221207_071637_252705_B7C156FC 
X-CRM114-Status: GOOD (  15.27  )
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


> Hi Sagi,
> 
> Do you mean show_opcode_name() macro which is defined as part of TRACE_EVENT?
> 
> As far as I understand, I can't use show_opcode_name() directly outside of TRACE_EVENT
> 
> Can you please share an example?

Sorry, I meant something like nvme_get_opcode_str()...

Something like (untested and needs a split):
--
diff --git a/drivers/nvme/host/constants.c b/drivers/nvme/host/constants.c
index e958d5015585..eacf282f04d8 100644
--- a/drivers/nvme/host/constants.c
+++ b/drivers/nvme/host/constants.c
@@ -54,6 +54,14 @@ static const char * const nvme_admin_ops[] = {
         [nvme_admin_get_lba_status] = "Get LBA Status",
  };

+static const char * const nvme_fabrics_ops[] = {
+       [nvme_fabrics_type_property_set] = "Property Set",
+       [nvme_fabrics_type_connect] = "Connect",
+       [nvme_fabrics_type_property_get] = "Property Get",
+       [nvme_fabrics_type_auth_send] = "Authentication Send",
+       [nvme_fabrics_type_auth_receive] = "Authentication Receive",
+};
+
  static const char * const nvme_statuses[] = {
         [NVME_SC_SUCCESS] = "Success",
         [NVME_SC_INVALID_OPCODE] = "Invalid Command Opcode",
@@ -185,3 +193,12 @@ const unsigned char *nvme_get_admin_opcode_str(u8 
opcode)
                 return nvme_admin_ops[opcode];
         return "Unknown";
  }
+EXPORT_SYMBOL_GPL(nvme_get_admin_opcode_str);
+
+const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode)
+{
+       if (opcode < ARRAY_SIZE(nvme_admin_ops) && nvme_fabrics_ops[opcode])
+               return nvme_fabrics_ops[opcode];
+       return "Unknown";
+}
+EXPORT_SYMBOL_GPL(nvme_get_fabrics_opcode_str);
diff --git a/drivers/nvme/host/nvme.h b/drivers/nvme/host/nvme.h
index e01fa9f696fa..56f2cec6e5b1 100644
--- a/drivers/nvme/host/nvme.h
+++ b/drivers/nvme/host/nvme.h
@@ -1086,19 +1086,30 @@ static inline bool nvme_multi_css(struct 
nvme_ctrl *ctrl)
  const unsigned char *nvme_get_error_status_str(u16 status);
  const unsigned char *nvme_get_opcode_str(u8 opcode);
  const unsigned char *nvme_get_admin_opcode_str(u8 opcode);
+const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode);
  #else /* CONFIG_NVME_VERBOSE_ERRORS */
  static inline const unsigned char *nvme_get_error_status_str(u16 status)
  {
-       return "I/O Error";
+       return __stringify(status);
  }
  static inline const unsigned char *nvme_get_opcode_str(u8 opcode)
  {
-       return "I/O Cmd";
+       return __stringify(opcode);
  }
  static inline const unsigned char *nvme_get_admin_opcode_str(u8 opcode)
  {
-       return "Admin Cmd";
+       return __stringify(opcode);
+}
+static inline const unsigned char *nvme_get_fabrics_opcode_str(u8 opcode)
+{
+       return __stringify(opcode);
  }
  #endif /* CONFIG_NVME_VERBOSE_ERRORS */
-
+static inline const unsigned char *nvme_opcode_str(int qid, u8 opcode, 
u8 fctype)
+{
+       if (opcode == nvme_fabrics_command)
+               return nvme_get_fabrics_opcode_str(fctype);
+       return qid ? nvme_get_opcode_str(opcode) :
+               nvme_get_admin_opcode_str(opcode);
+}
  #endif /* _NVME_H */
diff --git a/drivers/nvme/host/tcp.c b/drivers/nvme/host/tcp.c
index 79789daddeac..77450f52c146 100644
--- a/drivers/nvme/host/tcp.c
+++ b/drivers/nvme/host/tcp.c
@@ -2275,10 +2275,13 @@ static enum blk_eh_timer_return 
nvme_tcp_timeout(struct request *rq)
         struct nvme_tcp_request *req = blk_mq_rq_to_pdu(rq);
         struct nvme_ctrl *ctrl = &req->queue->ctrl->ctrl;
         struct nvme_tcp_cmd_pdu *pdu = req->pdu;
+       u8 opcode = pdu->cmd.common.opcode, fctype = 
pdu->cmd.fabrics.fctype;
+       int qid = nvme_tcp_queue_id(req->queue);

         dev_warn(ctrl->device,
-               "queue %d: timeout request %#x type %d\n",
-               nvme_tcp_queue_id(req->queue), rq->tag, pdu->hdr.type);
+               "queue %d: timeout cid %#x type %d op %s\n",
+               qid, nvme_cid(rq), pdu->hdr.type,
+               nvme_opcode_str(qid, opcode, fctype));

         if (ctrl->state != NVME_CTRL_LIVE) {
                 /*
--

