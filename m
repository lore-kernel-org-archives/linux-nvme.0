Return-Path: <linux-nvme-bounces+linux-nvme=archiver.kernel.org@lists.infradead.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from bombadil.infradead.org (bombadil.infradead.org [198.137.202.133])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D740CFD4F08
	for <linux-nvme@archiver.kernel.org>; Tue, 10 Mar 2026 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=lists.infradead.org; s=bombadil.20210309; h=Sender:List-Subscribe:List-Help
	:List-Post:List-Archive:List-Unsubscribe:List-Id:Content-Transfer-Encoding:
	Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
	Message-ID:Reply-To:Content-ID:Content-Description:Resent-Date:Resent-From:
	Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Owner;
	bh=qEnF/Lg25U18+ZKcj41EcZIOIb03fm6HJ1Ff4fvEotU=; b=GInqQPomYMzz7QxqT2DlgQsMZE
	4BwQWWzd73tgMAH2rSkoIR8l5FHukbd7tnnwDC8b/sRKeoIsGkr7LtSBfVBzHWtvvbYM/CE02blrp
	2T5sDkVEVWLQmGb5swBPuZvdjRl1DLM1F84+ZQQHpRPKjjMPCkGuKRXHNsLrAADFnEpuDe8hlDyFJ
	/1w6VD83wyH8OZO8/5rrrMOzOxdm8IOM2kN8aFM5IYUbsMKNjrNY+DIA6IJZxM1GqSiBR5+vfOHDS
	MEBnMfEyJcTMA94J+dYU23uKidKv8deIpDPwZ17qugFSMy+rd219RavrO+2Az0rL2VmFbDH+zFkQr
	jHdSFb0A==;
Received: from localhost ([::1] helo=bombadil.infradead.org)
	by bombadil.infradead.org with esmtp (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01IH-0000000A1gf-0C8A;
	Tue, 10 Mar 2026 17:54:57 +0000
Received: from mail-wr1-x429.google.com ([2a00:1450:4864:20::429])
	by bombadil.infradead.org with esmtps (Exim 4.98.2 #2 (Red Hat Linux))
	id 1w01IE-0000000A1fB-2jRX
	for linux-nvme@lists.infradead.org;
	Tue, 10 Mar 2026 17:54:55 +0000
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-439c4bde55cso5073689f8f.1
        for <linux-nvme@lists.infradead.org>; Tue, 10 Mar 2026 10:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=suse.com; s=google; t=1773165293; x=1773770093; darn=lists.infradead.org;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qEnF/Lg25U18+ZKcj41EcZIOIb03fm6HJ1Ff4fvEotU=;
        b=Ip7oDFbAwrDIohG1G4qJGGtQcg1Pm8PmJWDTBzkEOCZnE/xcHPH6LwCvDzIKC4fbPs
         oezxxhvGqnB49XKuSWF+xvZb5LvBDKSHHddv9dTfPz0vJewqA/KkqgTIlKBxUcaWpOWp
         MHo1+vlpKxKGQ+llAbg4nkPUuMozYljqQ4GCAjX9ryl7t56jzf9biD9NEQEU4dY/8FWl
         vYqKrEOfKz9Mj7W36tnL2vm2Ta8PsCvGDOVXXEQCzxbdJ53lopNFsozMEePEopi1K6Qh
         JJCeh2agYmugqRmC+BQoeEjmot4PNlsRAKbq5bvXxhpYp0MbCSI9oVTGk2PtXHlynbaw
         dlPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1773165293; x=1773770093;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qEnF/Lg25U18+ZKcj41EcZIOIb03fm6HJ1Ff4fvEotU=;
        b=dNn16+5BqB3aWi8R2dKA/xCRu7OX5O6iM9l/LDz/mIP4OQR3ILNEqeA37XSq+6tfga
         c1QRm925QKl/lfPgUw6TAEjmg5iB/6g2I3mDJpCC/bSOoXjWZw/zITW4E5T3ETpI0Xp+
         2lYQMRBE9946jl+zxnTwJayVKkhX23MOYetZYdBWJBt1+Ls9/qf/mmN4VSvDdg+GwJNz
         3fiFewmLknu9k+vMhKzc6PmdoMvd7CTjykXJH36lLguVlZNuUFUUj+i3ne1+k2nKqW+g
         GjvUNi4ZKKeMjjjh7B8s273iJdYVh/Bt1xAn/pwQztFbqjjnyvN3dOwp5LeGaq8pvEKd
         4NLg==
X-Forwarded-Encrypted: i=1; AJvYcCWJB1Nt9B85wplABM/FmUxdfn6l9te6KHhswTeLwhCXvgDEo99oBOnil+Tcu21DCM7lH0pdI5wW8SS6@lists.infradead.org
X-Gm-Message-State: AOJu0YzCg3jBHFSHI9LjFNFSfiCgCpvnBq23b4U31fL63/Dl22mUeod0
	gxy60CK9UG/BBi3sYZVqXHrKQL6/METov4bX/U+jbXtqBFZx3l+hKkjuysREGwK4kKk=
X-Gm-Gg: ATEYQzxViF+wz4nXnVmGlhOq0OheuGZUSlItf9zkECimnKQplYOE1Ht1GZ/9GUeL8F9
	eYefV69TsXCONTjG6sxi0db7hkQwpVH+UxZK6vLRprIvW/C6hWh7kevIYWV+LSJgopJRWTPoxa+
	nGTdOwtBU1FlAUdDTEAzYWElzuWoNIq8d3PlUAIfRtqBLY2TtRxKFlzbISjSbGwXkzbaI10IdzZ
	++/vICPnRgpTE9mn2cL0wnSD01GO62b89fOT/cQji05uzF5d9fG4kc9H8EHaJJRFDTWm9+5SJvh
	hswTKN8QnPFqv9dD+R+uFNAtnNyMJRdTa4GXyIKSpUNxZOrvWkT9ndkI/IMPsW5cjr6uLZvwKFN
	7r4gP0Nf6oi58EiiNjimuuOOl6pgoTDdBf2obhzRwfEDdggBWiS1S4YEoxsH/QeHvoKacjHBeje
	q/xqNtfi6EQEoj3YztcONUm8fSriSYBrK4jt3tUB+kNBoAEgILZ6IEOlaof21D
X-Received: by 2002:a05:600c:4f07:b0:485:3171:7845 with SMTP id 5b1f17b1804b1-48531717a94mr200528055e9.4.1773165292732;
        Tue, 10 Mar 2026 10:54:52 -0700 (PDT)
Received: from ?IPV6:2001:a61:2a16:da01:fd99:79eb:2f5d:d346? ([2001:a61:2a16:da01:fd99:79eb:2f5d:d346])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-48541b6f708sm126141845e9.11.2026.03.10.10.54.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 Mar 2026 10:54:52 -0700 (PDT)
Message-ID: <6b6a822c-4e49-4e80-ba57-57704e3c1307@suse.com>
Date: Tue, 10 Mar 2026 18:54:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 5/8] scsi: scsi-multipath: Add basic ALUA support
To: John Garry <john.g.garry@oracle.com>, hch@lst.de, kbusch@kernel.org,
 martin.petersen@oracle.com, james.bottomley@hansenpartnership.com,
 bmarzins@redhat.com
Cc: jmeneghi@redhat.com, linux-nvme@lists.infradead.org, sagi@grimberg.me,
 axboe@fb.com, linux-scsi@vger.kernel.org, michael.christie@oracle.com,
 snitzer@kernel.org, dm-devel@lists.linux.dev, linux-kernel@vger.kernel.org,
 nilay@linux.ibm.com
References: <20260310114925.1222263-1-john.g.garry@oracle.com>
 <20260310114925.1222263-6-john.g.garry@oracle.com>
 <f46807c2-0266-4143-9caa-ff938293f7b4@suse.com>
 <3178d371-7a4c-4d07-885c-42496190f242@oracle.com>
Content-Language: en-US
From: Hannes Reinecke <hare@suse.com>
In-Reply-To: <3178d371-7a4c-4d07-885c-42496190f242@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CRM114-Version: 20100106-BlameMichelson ( TRE 0.8.0 (BSD) ) MR-646709E3 
X-CRM114-CacheID: sfid-20260310_105454_715620_C8810A48 
X-CRM114-Status: GOOD (  20.71  )
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

On 3/10/26 16:52, John Garry wrote:
> On 10/03/2026 13:23, Hannes Reinecke wrote:
>>>       sdev->scsi_mpath_dev->index = ida_alloc(&scsi_mpath_head->ida, 
>>> GFP_KERNEL);
>>>       if (sdev->scsi_mpath_dev->index < 0) {
>>>           ret = sdev->scsi_mpath_dev->index;
>>> diff --git a/include/scsi/scsi_multipath.h b/include/scsi/ 
>>> scsi_multipath.h
>>> index 2011447f482d6..7c7ee2fb7def7 100644
>>> --- a/include/scsi/scsi_multipath.h
>>> +++ b/include/scsi/scsi_multipath.h
>>> @@ -38,6 +38,9 @@ struct scsi_mpath_device {
>>>       int            index;
>>>       atomic_t        nr_active;
>>>       struct scsi_mpath_head    *scsi_mpath_head;
>>> +    int            alua_state;
>>> +    int            alua_pref;
>>> +    int            alua_valid_states;
>>>       char            device_id_str[SCSI_MPATH_DEVICE_ID_LEN];
>>>   };
>>
>> Is there a specific reason why this cannot be in the generic code?
> 
> Sure, it's possible....
> 
>> After all, if the device reports anything else than ALUA_STATE_OPTIMAL
>> or ALUA_STATE_ACTIVE I/O will fail, irrespective of multipath being
>> active.
>>
>> I would love to see that in the generic SCSI code, independent on this 
>> patchset. It would allow us to simplify the device handler code, too,
>> as then device handler really would only be required for explicit
>> ALUA. (And could be ignored for scsi-multipathing).
> 
> Right, so you would like to see alua_port_group management in a core 
> ALUA driver as well, right?
> 
> If yes, to repeat, it is hard to separate the DH stuff out...but I can 
> try. Examples I would need to deal with (and associated handling):
> 
> - alua_port_group members like dh_list
> - alua_dh_data memebers like init_error
> - everything in alua_queue_data
> 
While the port group handling looks nice (and there certainly is
a certain neatness to it), it kinda assumes too much about the
internal layout of the hierarchy within the target.
Technically, a target is only required to provide a device
identifier, and a group id (such that you can match with
RTPG output). However, you have no idea which of the various
device IDs are part of the same enclosure; that information
is not required to be present.
So you cannot assume that group ID A reported from device X
is the same group as group ID A reported from device Y.
The only reliable way is to check with the RTPG output, as
that contains all device identifiers for the defined group
IDs.
But: caching RTPG output is problematic (as it'll change
whenever a path state change happens), and it'll need to
contain references to the SCSI devices, introducing all
sorts of locking issues and race conditions.
So probably I would not go down that way (at least initially),
but rather read RTPG during scanning, and set the values
directly in the scsi device.

We then need to re-read that information whenever we hit
a relevant sense code, but arguably we'll need to do that
anyway.

Cheers,

Hannes
-- 
Dr. Hannes Reinecke                  Kernel Storage Architect
hare@suse.com                               +49 911 74053 688
SUSE Software Solutions GmbH, Frankenstr. 146, 90461 Nürnberg
HRB 36809 (AG Nürnberg), GF: I. Totev, A. McDonald, W. Knoblich

