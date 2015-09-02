From: m@bjorling.me (=?UTF-8?B?TWF0aWFzIEJqw7hybGluZw==?=)
Date: Wed, 02 Sep 2015 12:48:58 +0200
Subject: [PATCH v7 1/5] lightnvm: Support for Open-Channel SSDs
In-Reply-To: <55E67218.9010701@cn.fujitsu.com>
References: <1438957791-24632-1-git-send-email-mb@lightnvm.io>
 <1438957791-24632-2-git-send-email-mb@lightnvm.io>
 <55E67218.9010701@cn.fujitsu.com>
Message-ID: <55E6D41A.5060100@bjorling.me>

>> +
>> +    /* register with device with a supported BM */
>> +    list_for_each_entry(bt, &nvm_bms, list) {
>> +        ret = bt->register_bm(dev);
>> +        if (ret < 0)
>> +            goto err; /* initialization failed */
>> +        if (ret > 0) {
>> +            dev->bm = bt;
>> +            break; /* successfully initialized */
>> +        }
>> +    }
>
> Why just search it from head to tail? Can user specific it
> in nvm_create_target()?

Hi Yang,

Currently only the rrpc and a couple of out of tree block managers are 
built. The register_bm only tries to find a block manager that supports 
the device, when it finds it, that  one is initialized. It is an open 
question on how we choose the right block manager, e.g. a proprietary 
and a open-source block manager is in place. Priorities might be a way 
to go? or mark certain block managers as a catch all?

Hopefully we will get away with only a single or two block managers in 
the future, so we won't have one for each type of device.

>> +
>> +    if (!ret) {
>> +        pr_info("nvm: no compatible bm was found.\n");
>> +        return 0;
>> +    }
>
> If we allow nvm_device registered with no bm, we would get
> a NULL pointer reference problem in later using.
>

Yes, definitely. In the care that happens, I envision it should be 
possible to register a block manager after a device is loaded, and then 
any outstanding devices (which does not have a registered block 
manager), will be probed again.

> As mentioned above, why we have to choose bm for nvm in nvm_register?

Without a block manager, we don't know the structure of the device and 
how to interact with it. I want to initialize that as soon as possible. 
So that layers on top can start interacting.

>
> Thanx
> Yang
