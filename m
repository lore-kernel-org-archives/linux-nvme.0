From: arnd@arndb.de (Arnd Bergmann)
Date: Fri, 10 Feb 2017 12:00:03 +0100
Subject: [PATCH V3 2/2] Move stack parameters for sed_ioctl to prevent
 oversized stack with CONFIG_KASAN
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6DB02833C4@AcuExch.aculab.com>
References: <1486660801-5105-1-git-send-email-scott.bauer@intel.com>
 <1486660801-5105-3-git-send-email-scott.bauer@intel.com>
 <e82756b9-df77-6033-b6ce-fbf9aac3b9a8@suse.de>
 <063D6719AE5E284EB5DD2968C1650D6DB02833C4@AcuExch.aculab.com>
Message-ID: <CAK8P3a1VkAjZyWbJEUBFsuH2096cVbXZsYX-KpZDwvvVUE3G5w@mail.gmail.com>

On Fri, Feb 10, 2017@11:28 AM, David Laight <David.Laight@aculab.com> wrote:

>>
>> > -           if (copy_from_user(&session, arg, sizeof(session)))
>> > -                   return -EFAULT;
>> > -           return opal_erase_locking_range(dev, &session);
>> > +   ioctl_ptr = kzalloc(cmd_size, GFP_KERNEL);
>> > +   if (!ioctl_ptr)
>> > +           return -ENOMEM;
>> > +   if (copy_from_user(ioctl_ptr, arg, cmd_size)) {
>> > +           ret = -EFAULT;
>> > +           goto out;
>> >     }
>>
>> Can't we use memdup_user() instead of kzalloc() + copy_from_user()?
>
> You either want the copy_from_user() or the memzero() not both.
>
> ISTM there could be two 'library' functions, maybe:
> void *get_ioctl_buf(unsigned int cmd, long arg)
> to malloc the buffer, memzero/copy_from_user, returns -EFAULT if copy fails.
> int put_ioctl_buf(int rval, unsigned int cmd, const void *buf)
> does copy_to_user() if rval >= 0 and IOR_READ, then frees buf.
> return value is rval unless the copyout fails.

All the ioctls commands in this driver are IOW, and no data is passed back
to user space, so there is no need for the memzero(): we can either copy
the data from user space or we fail.

    Arnd
