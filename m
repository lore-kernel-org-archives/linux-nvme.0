From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 15 Jul 2019 18:13:19 -0700
Subject: [PATCH rfc v2 05/10] nvme-cli: extend ctrl_list_item for connect
 attributes
In-Reply-To: <721a6054-6e49-0fcb-2928-127470b798f6@gmail.com>
References: <20190712003140.16221-1-jsmart2021@gmail.com>
 <20190712003140.16221-6-jsmart2021@gmail.com>
 <6647e40b-cfc9-46e3-cd11-aeaaec8eeff6@grimberg.me>
 <721a6054-6e49-0fcb-2928-127470b798f6@gmail.com>
Message-ID: <a6f99081-0c14-6de8-7a93-45ebdec8377f@grimberg.me>


>>> +char *__parse_connect_arg(char *conargs, const char delim, const 
>>> char *fieldnm)
>>> +{
>>> +??? char *s, *e;
>>> +??? size_t cnt;
>>> +
>>> +??? /*
>>> +???? * There are field name overlaps: traddr and host_traddr.
>>> +???? * By chance, both connect arg strings are set up to
>>> +???? * have traddr field followed by host_traddr field. Thus field
>>> +???? * name matching doesn't overlap in the searches. Technically,
>>> +???? * as is, the loop and delimiter checking isn't necessary.
>>> +???? * However, better to be prepared.
>>> +???? */
>>> +??? do {
>>> +??????? s = strstr(conargs, fieldnm);
>>
>> Any reason not to use the normal strsep for loop?
> 
> strsep wasn't used as I didn't want to modify the args string.
> 
> I could convert, but it means I need to duplicate the args string both 
> in do_discover and in the nvme_ctrl_listitem routine or have the parse
> routine duplicate it then throw it away. Using strsep would also mean I 
> have to continue to have the check for '=' token and extracting the 
> value. Not sure I gain much code reduction.
> 
> Any preference over leaving as is or having the parse routine duplicate 
> it ?

No hard emotions on this, just thought it would be less convoluted and
more common with other parsers, but if its create a more convoluted code
we don't have to go there...
