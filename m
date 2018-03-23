From: sim@linux.vnet.ibm.com (Narasimhan V)
Date: Fri, 23 Mar 2018 12:59:53 +0530
Subject: nguid for nvme over fabrics
In-Reply-To: <4ab62a0f-5cee-cf62-33b3-f4097d34cf72@grimberg.me>
References: <410a2655c6f5e4ed9e1c2af36b72f3ee@linux.vnet.ibm.com>
 <4ab62a0f-5cee-cf62-33b3-f4097d34cf72@grimberg.me>
Message-ID: <0832b33613cb166a1c3f46dd3c5d407d@linux.vnet.ibm.com>

On 2018-03-23 00:32, Sagi Grimberg wrote:
>> Hi,
>> 
>> I am trying nvme over fabrics, and found this: nguid is set to 0s by 
>> default for all devices.
>> 
>> So, nguid can be same (0s in this case) for multiple devices. Is this 
>> valid ?
>> Also, same nguid for multiple devices could be set, by the above 
>> scenario.
>> No errors/warnings from either the nvme initiator/target.
>> 
>>  From spec, I see this:
>> Namespace Globally Unique Identifier (NGUID): This field contains a 
>> 128-bit value that is
>> globally? unique and assigned to? the? namespace? when? the? 
>> namespace is? created.? This? field
>> remains fixed throughout the life of the namespace and is preserved 
>> across namespace and
>> controller operations (e.g., controller reset,? namespace format, 
>> etc.).
> 
> We generate a UUID (which can be overwritten by the user)

Shouldn't it be unique ?
I have instances where for NVMef, multiple devices can have same nguids.
Which component should be responsible to generate nguid in NVMef ?


-- 
Regards
Narasimhan V
