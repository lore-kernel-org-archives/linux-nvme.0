From: sagi@grimberg.me (Sagi Grimberg)
Date: Mon, 10 Jun 2019 17:01:55 -0700
Subject: [PATCH V6 6/6] fabrics: Return errno mapped for fabrics error
 status
In-Reply-To: <20190608200112.GC28228@minwoo-900X5N>
References: <20190604154034.23386-1-minwoo.im.dev@gmail.com>
 <20190604154034.23386-7-minwoo.im.dev@gmail.com>
 <BYAPR04MB57497DFEEC77ED6D43998ED086110@BYAPR04MB5749.namprd04.prod.outlook.com>
 <20190608200112.GC28228@minwoo-900X5N>
Message-ID: <7710edd4-5277-615c-426f-f9d48da8cb99@grimberg.me>


> On 19-06-08 19:36:42, Chaitanya Kulkarni wrote:
>>> @@ -874,9 +877,11 @@ static int do_discover(char *argstr, bool connect)
>>>    	case DISC_GET_NUMRECS:
>>>    		fprintf(stderr,
>>>    			"Get number of discovery log entries failed.\n");
>>> +		ret = status;
>>>    		break;
>>>    	case DISC_GET_LOG:
>>>    		fprintf(stderr, "Get discovery log entries failed.\n");
>>> +		ret = status;
>>>    		break;
>>>    	case DISC_NO_LOG:
>>>    		fprintf(stdout, "No discovery log entries to fetch.\n");
>>> @@ -885,6 +890,7 @@ static int do_discover(char *argstr, bool connect)
>>>    	case DISC_NOT_EQUAL:
>>>    		fprintf(stderr,
>>>    		"Numrec values of last two get discovery log page not equal\n");
>>> +		ret = DISC_OK;
>> Can you please explain above assignment ?
> 
> Even it fails due to a mismatch between numrec in the header and the
> actual nr_entries, the discovery log-page has been done successfully
> whose status code should be in zero.
> 
> That code is just returning 0 to the caller which does not need to fail
> due to this reason.  You may ask me why I didn't do like:
> 	ret = 0;
> 
> That is just following the code right above which is a case for
> DISC_NO_LOG.
> 
> What do you think about it ?

Shouldn't we start over in this case?
