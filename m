From: monis@mellanox.com (Moni Shoua)
Date: Thu, 9 Mar 2017 12:59:31 +0200
Subject: Need some pointers to debug a KASAN splat in NVMe over Fabrics
 with rdma-rxe
In-Reply-To: <38a12b22-7bad-c069-4c96-39fc93d20d79@suse.de>
References: <5b16edcf-c39a-bc4b-0e32-8ccfb5d75efb@suse.de>
 <CAG9sBKPwEryc7U+hV=XJvRrFFhNvoktDOtwwS6piUw=cQ=bZhA@mail.gmail.com>
 <38a12b22-7bad-c069-4c96-39fc93d20d79@suse.de>
Message-ID: <CAG9sBKNXwHFkmQYsOPPu40822h6Z7J3+63CaZ844juZp5hfHfg@mail.gmail.com>

>> 2. You can take a look at librxe implementation of init_send_wqe() (it
>> looks slightly different from kernel's implementation) and see what
>> happens if you change implementation accordingly.
>
> OK I'll have a look and hopefully come back with a (RFC) patch (fingers
> crossed).

Thanks. Waiting to see what you found and in the meantime I'll try to
reproduce in my setup
