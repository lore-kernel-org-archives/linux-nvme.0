From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 1 Jul 2019 22:38:31 -0700
Subject: [PATCH 2/2] nvme: flush scan_work when resetting controller
In-Reply-To: <c73a67c6-719a-78a8-98b0-5679d08a115f@grimberg.me>
References: <20190618101025.78840-1-hare@suse.de>
 <20190618101025.78840-3-hare@suse.de>
 <36c093c6-9fea-aa2f-affe-70957e0c5b1b@grimberg.me>
 <681a1c11-7d11-6e28-bc64-b14bef22c144@suse.com>
 <fe550375-fc5d-ff19-c303-6671b8713df6@grimberg.me>
 <d64a5902-139e-4119-ec75-3394e0b129f9@suse.de>
 <d84bf42f-c9fe-6af4-58cc-14195ddff931@grimberg.me>
 <68599577-450a-ade1-451c-f310e5094317@grimberg.me>
 <66f3dd84-77cd-fc45-025c-4082cf3df7ec@suse.de>
 <2a6168f3-37f6-1acf-2e89-48a3b9cac8e1@grimberg.me>
 <ff13e243-da8f-f04c-d31b-f7c46d3a4375@suse.de>
 <960997d6-9ce3-5730-00e6-5b2639502eaa@grimberg.me>
 <04a61807-ed2c-c91a-6eeb-c3df864fedc4@suse.de>
 <c73a67c6-719a-78a8-98b0-5679d08a115f@grimberg.me>
Message-ID: <0a1029ce-c140-f51e-9402-b98483f0b9e9@grimberg.me>


>> Hmm. Not sure if that is sufficient, though.
>> We do issue several I/O in the course of nvme_revalidate_disk(), and 
>> as we're running fully asynchronous here the disk might be removed at 
>> any given time. Cf the above stack trace; we're getting an error for 
>> the _second_ I/O (nvme_identify_ns is issuing I/O, too, but went 
>> through without errors).
> 
> Its not protecting against the I/O, but rather against queue freeze.
> 
>> So if we were to go that route we'd need to protect each and every I/O 
>> with that test.
> 
> Why?

Hannes?
