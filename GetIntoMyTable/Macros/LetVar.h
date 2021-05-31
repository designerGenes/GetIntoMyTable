//
//  LetVar.h
//  GetIntoMyTable
//
//  Created by Jaden Nation on 5/30/21.
//

#ifndef LetVar_h
#define LetVar_h

#if defined(__cplusplus)
#define let auto const
#else
#define let const __auto_type
#endif

#if defined(__cplusplus)
#define var auto
#else
#define var __auto_type
#endif

#endif /* LetVar_h */
